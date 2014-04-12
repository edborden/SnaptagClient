ApplicationRoute = Ember.Route.extend(
	beforeModel: ->
		@_super()
		FB.getLoginStatus((response) =>
			if response.status is "connected"
				$.ajaxSetup(
					data: {"token": response.authResponse.accessToken,"facebookid": response.authResponse.userID}
				)
				pusher = new Pusher('0750760773b8ed5ae1dc')
				channel = pusher.subscribe(response.authResponse.userID)
				channel.bind('updatelocation', =>
					@send('updatelocation')
					)
			else
				@replaceWith('index')
		)
	actions:
		updatelocation: ->
			console.log "UPDATELOCATION EVENT"

)

`export default ApplicationRoute`