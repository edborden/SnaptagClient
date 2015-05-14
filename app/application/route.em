`import ServerTalk from 'stalkers-client/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	beforeModel: ->
		@session.openWithToken(localStorage.stalkersToken) if localStorage.stalkersToken

	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'
		login: ->
			@transitionTo('loading').then =>
				@torii.open('facebook-token').then (authorization) =>
					@session.openWithUser(authorization.authorizationToken.token).then =>
						if @session.active
							@transitionTo 'map'
							#Bootstrap.GNM.push 'Logged In', 'You are now in-game.', 'success'
						else
							@transitionTo 'inactivemap'
							#Bootstrap.GNM.push 'Logged In', 'You may now Activate.', 'success' if @session.inactive
							#Bootstrap.GNM.push 'Logged In', 'You are waiting for other players.', 'success' if @session.queue
		join: ->
			@transitionTo('loading').then =>
				@getServer("hunts/join",{location: @geolocation.object}).then (response) =>
					response = Ember.$.parseJSON response
					@store.pushPayload response
					@session.me.notifyPropertyChange 'status' # fixes status not updating if re-enter queue on same session
					if @session.active
						#Bootstrap.GNM.push 'Sleeper Activated.', 'You are now in-game.', 'success'
						@transitionTo 'map'
					else 
						#Bootstrap.GNM.push 'Queue entered.', 'You are waiting to play.', 'success'
						@transitionTo 'inactivemap'
		unjoin: ->
			@getServer "hunts/unjoin"
			@session.me.status = 'inactive'
			#Bootstrap.GNM.push 'Queue exited.', 'You are inactive.', 'success'

		found: (target) ->
			@transitionTo 'loading'
			@getServer('hunts/found_target', {target_id: target.id}).then (response) =>
				notification = @pushUnparsedNotification response
				@me.suspects.removeObject target
				@me.targetsFoundCount = @me.targetsFoundCount + 1
				#Bootstrap.GNM.push 'Success', 'Target Found.', 'success'
				@transitionTo 'map'
		expose: (suspect) ->
			@transitionTo 'loading'
			@getServer('hunts/expose', {stalker_id: suspect.id}).then (response) =>
				notification = @pushUnparsedNotification response
				if notification.subject is "Stalker exposed"
					@me.suspects.removeObject suspect
					@me.targets.removeObject suspect
					@me.notifyPropertyChange 'suspects'
					#Bootstrap.GNM.push 'Success', 'Stalker exposed.', 'success'
					@transitionTo 'map'
				if notification.subject is "Exposed self"
					@me.exposedCount = @me.exposedCount + 1
					@goInactive()
					#Bootstrap.GNM.push 'Failed', 'You exposed yourself.', 'warning'

	pushUnparsedNotification: (response) ->
		response = Ember.$.parseJSON response
		@pushNotification response

	goInactive: ->
		@me.status = 'inactive'
		@me.suspects.clear()
		@me.targets.clear()		
		@transitionTo 'inactivemap'

	pushNotification: (response) ->
		@store.pushPayload response
		notification = @store.getById 'notification',response.notification.id
		@me.notifications.unshiftObject notification
		return notification		

`export default ApplicationRoute`