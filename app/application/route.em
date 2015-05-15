`import ServerTalk from 'stalkers-client/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	growler:Ember.inject.service()

	me: ~> @session.me

	beforeModel: ->
		@session.openWithToken(localStorage.stalkersToken) if localStorage.stalkersToken

	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'
			@growler.growl 1
		login: ->
			@transitionTo('loading').then =>
				@torii.open('facebook-token').then (authorization) =>
					@session.openWithUser(authorization.authorizationToken.token).then =>
						if @session.active
							@transitionTo 'map'
							@growler.growl 2
						else
							@transitionTo 'inactivemap'
							if @session.inactive
								@growler.growl 3
							else
								@growler.growl 4
		join: ->
			@transitionTo('loading').then =>
				@getServer("hunts/join",{location: @geolocation.object}).then (response) =>
					response = Ember.$.parseJSON response
					@store.pushPayload response
					@session.me.notifyPropertyChange 'status' # fixes status not updating if re-enter queue on same session
					if @session.active
						@transitionTo 'map'
						@growler.growl 5
					else 
						@transitionTo 'inactivemap'
						@growler.growl 6
						
		unjoin: ->
			@getServer "hunts/unjoin"
			@session.me.status = 'inactive'
			@growler.growl 7

		found: (target) ->
			@transitionTo 'loading'
			@getServer('hunts/found_target', {target_id: target.id}).then (response) =>
				#notification = @pushUnparsedNotification response
				@me.suspects.removeObject target
				@me.targetsFoundCount = @me.targetsFoundCount + 1
				@transitionTo 'map'
				@growler.growl 8
		expose: (suspect) ->
			@transitionTo 'loading'
			@getServer('hunts/expose', {stalker_id: suspect.id}).then (response) =>
				notification = @pushUnparsedNotification response
				if notification.subject is "Stalker exposed"
					@me.suspects.removeObject suspect
					@me.targets.removeObject suspect
					@me.notifyPropertyChange 'suspects'
					@transitionTo 'map' 
					@growler.growl 9
				if notification.subject is "Exposed self"
					@me.exposedCount = @me.exposedCount + 1
					@goInactive()
					@growler.growl 10

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