class ApplicationController extends Ember.ObjectController
	currentLocation: null
	active: true
	queue: false
	loggedIn: null
	transmitting: true

	init: ->
		#app = this
		@setClientLoggedIn()
		navigator.geolocation.watchPosition( (position) => @currentLocation = position,null, {enableHighAccuracy:true})
		@getLocation()
		@_super()
		#`setInterval(function(){app.getLocation()},60000);`

	+observer currentLocation
	currentLocationChanged: ->
		return

	setClientLoggedIn: ->
		if localStorage.fbtoken? then @loggedIn = true else @loggedIn = false

	getLocation: ->
		navigator.geolocation.getCurrentPosition( (position) => @currentLocation = position,null,{timeout:0,maximumAge:Infinity,enableHighAccuracy:true})

`export default ApplicationController`