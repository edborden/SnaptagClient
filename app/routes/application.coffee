ApplicationRoute = Ember.Route.extend(
	init: ->
		this._super()
		console.log "got it!"
		window.fbAsyncInit = ->
			FB.init(
				appId      : '726528350693125'
				status     : true
				cookie     : true
				xfbml      : true 
			)			
			FB.Event.subscribe('auth.authResponseChange', (response) ->
				if response.status == 'connected'
					->
						console.log('Welcome!  Fetching your information.... ')
						FB.api('/me', (response) ->
							console.log('Good to see you, ' + response.name + '.')
						)
				else if response.status == 'not_authorized' 
					FB.login()
				else
					FB.login()
			)
)

`export default ApplicationRoute`