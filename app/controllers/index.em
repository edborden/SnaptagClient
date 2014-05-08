class IndexController extends Ember.ArrayController
	needs: 'application'
	indexNav: true

	actions:
		login: ->
			@controllers.application.login()
			
	content: [
		{location: L.latLng(40.714, -74.000)},
		{location: L.latLng(40.714, -73.989)},
		{location: L.latLng(40.721, -73.991)}
	]

`export default IndexController`