`import ServerTalk from 'stalkers-client/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	beforeModel: ->
		@session.openWithToken(localStorage.stalkersToken) if localStorage.stalkersToken

	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'
			@notify.info "Logged out"
		login: ->
			@transitionTo('loading').then =>
				@torii.open('facebook-token').then (authorization) =>
					@session.openWithUser(authorization.authorizationToken.token).then =>
						if @session.active
							@transitionTo 'map'
							@notify.info 'Logged in! You are now in-game.'
						else
							@transitionTo 'inactivemap'
							if @session.inactive
								@notify.info 'Logged in! You may now Activate.'
							else
								@notify.info 'Logged in! You are waiting for other players.'
		join: ->
			@transitionTo('loading').then =>
				@getServer("hunts/join",{location: @geolocation.object}).then (response) =>
					response = Ember.$.parseJSON response
					@store.pushPayload response
					@session.me.notifyPropertyChange 'status' # fixes status not updating if re-enter queue on same session
					if @session.active
						@transitionTo 'map'
						@notify.info 'Stalker Activated. You are now in-game.'
					else 
						@transitionTo 'inactivemap'
						@notify.info 'Queue entered. You are waiting to play.'
						
		unjoin: ->
			@getServer "hunts/unjoin"
			@session.me.status = 'inactive'
			@notify.info 'Queue exited. You are inactive.'

		found: (target) ->
			@transitionTo 'loading'
			@getServer('hunts/found_target', {target_id: target.id}).then (response) =>
				notification = @pushUnparsedNotification response
				@me.suspects.removeObject target
				@me.targetsFoundCount = @me.targetsFoundCount + 1
				@transitionTo 'map'
				@notify.info 'Success! Target Found.'
		expose: (suspect) ->
			@transitionTo 'loading'
			@getServer('hunts/expose', {stalker_id: suspect.id}).then (response) =>
				notification = @pushUnparsedNotification response
				if notification.subject is "Stalker exposed"
					@me.suspects.removeObject suspect
					@me.targets.removeObject suspect
					@me.notifyPropertyChange 'suspects'
					@transitionTo 'map' 
					@notify.info 'Success! Stalker exposed.'
				if notification.subject is "Exposed self"
					@me.exposedCount = @me.exposedCount + 1
					@goInactive()
					@notify.info 'Failed... You exposed yourself.'

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