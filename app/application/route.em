`import ServerTalk from 'stalkers-client/mixins/server-talk'`
`import config from 'stalkers-client/config/environment'`

class ApplicationRoute extends Ember.Route with ServerTalk

	growler:Ember.inject.service()
	executive:Ember.inject.service()

	me: ~> @session.me

	beforeModel: ->
		@store.find('version').then( 
			(versions) =>
				device = {platform:'android'}
				if device?
					if device.platform is 'android' or device.platform is 'Android'
						remoteVersion = versions.filterBy('platform','android').firstObject.revision
					else
						remoteVersion = versions.filterBy('platform','ios').firstObject.revision
					localVersion = config.appVersion
					if remoteVersion > localVersion
						@session.updateApp = true
					else
						@session.openWithToken(localStorage.stalkersToken) if localStorage.stalkersToken
		)

	openSession: ->

	actions:

		logout: ->
			@session.close()
			@transitionTo 'index'
			@growler.growl 1

		login: ->
			@loader.in()
			@facebookLogin().then (token) =>
				@session.openWithUser(token).then =>
					if @session.active
						@loader.out()
						@transitionTo 'map'
						@growler.growl 2
					else
						@loader.out()
						@transitionTo 'inactivemap'
						if @session.inactive
							@growler.growl 3
						else
							@growler.growl 4

		join: ->
			@loader.in()
			@getServer("hunts/join",{location: @geolocation.object})
						
		unjoin: ->
			@getServer "hunts/unjoin"
			@session.me.status = 'inactive'
			@session.me.activationqueue = null
			@growler.growl 7

		found: (target) ->
			@loader.in()
			@getServer('hunts/found_target', {target_id: target.id})

		expose: (suspect) ->
			@loader.in()
			@getServer('hunts/expose', {stalker_id: suspect.id})

	facebookLogin: ->
		return new Ember.RSVP.Promise (resolve) =>
			if config.environment is 'production'
				facebookConnectPlugin.login(['email'], (response) -> 
					console.log 'Facebook connect success',response
					resolve response.authResponse.accessToken
				)
			else
				@torii.open('facebook-token').then (authorization) -> 
					console.log 'torii success',authorization
					resolve authorization.authorizationToken.token

`export default ApplicationRoute`