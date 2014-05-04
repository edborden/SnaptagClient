class ApplicationController extends Ember.ObjectController
	currentLocation: null
	active: false
	queue: false
	loggedIn: null
	transmitting: false
	intervalID: 0
	
	init: ->
		window.appp = this
		@setClientLoggedInStatus()
		navigator.geolocation.watchPosition( (position) => @currentLocation = position,null, {enableHighAccuracy:true})
		@getLocation()
		@_super()

	+observer currentLocation
	currentLocationChanged: ->
		if @locationAccurate and @internetConnection
			@transmitting = true
		else
			@transmitting = false if @transmitting is true

	+computed
	internetConnection: ->
		if cordova? 
			if navigator.connection.type is "none" then return false else return true
		else
			return true
			
	+computed
	locationAccurate: ->
		if cordova?
			if @currentLocation.coords.accuracy < 100 then return true else return false
		else 
			return true

	+observer transmitting
	transmittingChanged: ->
		if @transmitting
			@intervalID = @setInterval()
		else
			clearInterval @intervalID

	+observer loggedIn
	onLoggedInChange: ->
		if @loggedIn
			$.ajaxSetup {data: {"token": localStorage['fbtoken']}}
			@setPusher
			@setActiveStatus()
		else 
			return #need logout code

	setPusher: ->
		pusher = new Pusher '0750760773b8ed5ae1dc'
		channel = pusher.subscribe localStorage['fbtoken']
		channel.bind 'updatelocation', =>
			@send 'updatelocation'		

	getActiveStatus: ->
		Ember.$.ajax 
		url: "http://damp-sea-6022.herokuapp.com/users/status.json"
		success: setActiveStatus(response) 
		dataType: "text"

	setActiveStatus: (response) ->
		@active = true if response is 'active'
		@queue = true if response is 'queue'

	setInterval: ->
		app = this
		`setInterval(function(){app.sendLocation()},60000);`

	setClientLoggedInStatus: ->
		if localStorage.fbtoken? then @loggedIn = true else @loggedIn = false

	# This is only a setup function. The currentLocation will always be up-to-date after init from watchPosition()
	getLocation: ->
		navigator.geolocation.getCurrentPosition( (position) => @currentLocation = position,null,{timeout:0,maximumAge:Infinity,enableHighAccuracy:true})

	sendLocation: ->
		Ember.$.ajax 
			url: "http://damp-sea-6022.herokuapp.com/users/locations/update.json"
			data: 
				timestamp: @currentLocation.timestamp
				latitude: @currentLocation.coords.latitude
				longitude: @currentLocation.coords.longitude
				accuracy: @currentLocation.coords.accuracy

`export default ApplicationController`