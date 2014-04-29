class ApplicationController extends Ember.ObjectController

	currentLocation: null
	topNav: true

	init: ->
		app = this
		@_super()
		window.emberApplicationController = this
		navigator.geolocation.watchPosition(-> return,null, {enableHighAccuracy:true})
		@getLocation()
		`setInterval(function(){app.getLocation()},60000);`

	+observer currentLocation
	currentLocationChanged: ->
		console.log @currentLocation
		console.log "currentLocationChanged"

	getLocation: ->
		navigator.geolocation.getCurrentPosition( (position) => @currentLocation = position,null,{timeout:1,maximumAge:Infinity,enableHighAccuracy:true})

`export default ApplicationController`