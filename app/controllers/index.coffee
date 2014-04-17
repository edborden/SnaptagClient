IndexController = Ember.ArrayController.extend(
	init: ->
		navigator.geolocation.getCurrentPosition( (position) =>
			console.log("init in index controller" + position)
			hash = {location: L.latLng(position.coords.latitude,position.coords.longitude)}
			@content.pushObject(hash)

			enableHighAccuracy: true
		)
		navigator.geolocation.watchPosition( (position) =>
			console.log("init in index controller" + position)
			hash = {location: L.latLng(position.coords.latitude,position.coords.longitude)}
			@content.pushObject(hash)

			enableHighAccuracy: true
		)
		@_super()

	actions:
		login: ->
			window.plugins.spinnerDialog.show() if cordova?
			openFB.login('email,user_photos,user_birthday', =>
				$.get("http://damp-sea-6022.herokuapp.com/users/login.json",
					token: localStorage['fbtoken']
					(response) => 
						localStorage['fbtoken'] = response
						$.ajaxSetup(
							data: {"token": response}
						)
						pusher = new Pusher('0750760773b8ed5ae1dc')
						channel = pusher.subscribe(localStorage['fbtoken'])
						channel.bind('updatelocation', =>
							@send('updatelocation')
						)
						window.plugins.spinnerDialog.hide() if cordova?
						@transitionToRoute('world')
					"text"
				)
				(error) ->
					console.log('Facebook login failed: ' + error.error_description)
			)
	content: [
		{location: L.latLng(40.714, -74.000)},
		{location: L.latLng(40.714, -73.989)},
		{location: L.latLng(40.721, -73.991)}
	]
)

`export default IndexController`