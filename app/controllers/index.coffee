IndexController = Ember.ObjectController.extend(
	actions:
		login: ->
			FB.login( (response) =>
				if response.authResponse
					$.get("http://damp-sea-6022.herokuapp.com/users/login.json",
						facebookid: response.authResponse.userID
						token: response.authResponse.accessToken
						=> 
							@transitionToRoute('world')
							$.ajaxSetup(
								data: {"token": response.authResponse.accessToken,"facebookid": response.authResponse.userID}
							)
							pusher = new Pusher('0750760773b8ed5ae1dc')
							channel = pusher.subscribe(response.authResponse.userID)
							channel.bind('updatelocation', =>
								@send('updatelocation')
							)
					)
			{scope : "email,user_photos,user_birthday"}
			)

)

`export default IndexController`