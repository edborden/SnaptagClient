`import ServerTalk from 'stalkers-client/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	growler:Ember.inject.service()
	notificator:Ember.inject.service()
	executive:Ember.inject.service()

	me: ~> @session.me

	beforeModel: ->
		@session.openWithToken(localStorage.stalkersToken) if localStorage.stalkersToken

	actions:

		logout: ->
			@session.close()
			@transitionTo 'index'
			@growler.growl 1

		login: ->
			@transitionTo('loading')
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
			@transitionTo('loading')
			@getServer("hunts/join",{location: @geolocation.object})
						
		unjoin: ->
			@getServer "hunts/unjoin"
			@session.me.status = 'inactive'
			@growler.growl 7

		found: (target) ->
			@transitionTo 'loading'
			@getServer('hunts/found_target', {target_id: target.id})

		expose: (suspect) ->
			@transitionTo 'loading'
			@getServer('hunts/expose', {stalker_id: suspect.id})

`export default ApplicationRoute`