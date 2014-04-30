class IndexController extends Ember.ArrayController

	needs: ['application']

	actions:
		login: ->
			window.plugins.spinnerDialog.show() if cordova?
			openFB.login 'email,user_photos,user_birthday', => 
				Ember.$.ajax
					url: 'http://damp-sea-6022.herokuapp.com/users/login.json'
					data: {token: localStorage['fbtoken']}
					success: (response) =>
						localStorage['fbtoken'] = response
						$.ajaxSetup
							data: {"token": response}
						pusher = new Pusher('0750760773b8ed5ae1dc')
						channel = pusher.subscribe localStorage['fbtoken']
						channel.bind 'updatelocation', =>
							@send 'updatelocation'
						window.plugins.spinnerDialog.hide() if cordova?
						@transitionToRoute 'map'
					dataType: "text"

	content: [
		{location: L.latLng(40.714, -74.000)},
		{location: L.latLng(40.714, -73.989)},
		{location: L.latLng(40.721, -73.991)}
	]

`export default IndexController`