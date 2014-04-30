class ApplicationController extends Ember.ObjectController
	topNav: true
	currentLocation: null

	init: ->
		app = this
		@_super()
		navigator.geolocation.watchPosition(-> return,null, {enableHighAccuracy:true})
		@getLocation()
		`setInterval(function(){app.getLocation()},60000);`

	+observer currentLocation
	currentLocationChanged: ->
		return

	getLocation: ->
		navigator.geolocation.getCurrentPosition( (position) => @currentLocation = position,null,{timeout:1,maximumAge:Infinity,enableHighAccuracy:true})

`export default ApplicationController`