class ApplicationController extends Ember.ObjectController

	## PROPERTIES
	test2: null

	#+computed content.currentLocation
	#currentLocation: -> @content.currentLocation
#	active: null
#	queue: null
#	loggedIn: null
	transmitting: ~>
		if @active and @locationAccurate and @internetConnection then return true else return false
#	intervalID: null
#	internetConnection: null
	locationAccurate: ~>
		if cordova?
			if @currentLocation.coords.accuracy < 100 then return true else return false
		else 
			return true

	## APP INITIALIZATION
	
	init: ->
		@_super()

#		Ember.run.bind this, @setClientLoggedInStatus
#		navigator.geolocation.watchPosition( (position) => @currentLocation = position,null, {enableHighAccuracy:true})
#		@getLocation()
		console.log this.get('content')
		console.log @content
		console.log "active " + @active
		console.log "locationaccurate " + @locationAccurate
		console.log "internetconnection " + @internetConnection
		console.log "transmitting " + @transmitting
		console.log "loggedin " + @loggedIn
		console.log @currentLocation
		console.log @test1
		window.appp = this

	## TRANSMITTING

	+observer transmitting
	transmittingChanged: ->
		if @transmitting and @intervalID?
			@intervalID = @setInterval()
		if @transmitting is false and @intervalID
			clearInterval(@intervalID)
			@intervalID = null

	## ACTIVE / QUEUE

	setInitialActive: ->
		active = null
		Ember.$.ajax 
			url: "http://damp-sea-6022.herokuapp.com/users/status.json"
			success: (response) -> 
				if response is 'active' then @active = true else @active = false
			dataType: "text"
		return active

	setInitialQueue: ->
		queue = null
		Ember.$.ajax 
			url: "http://damp-sea-6022.herokuapp.com/users/status.json"
			success: (response) -> 
				if response is 'queue' then @queue = true else @queue = false
			dataType: "text"
		return queue

	getActiveStatus: ->
		Ember.$.ajax 
			url: "http://damp-sea-6022.herokuapp.com/users/status.json"
			success: (response) => Ember.run.bind this, @setActiveStatus(response)
			dataType: "text"

	setActiveStatus: (response) ->
		if response is 'active' then @active = true else @active = false
		if response is 'queue' then @queue = true else @queue = false

	## LOGGED IN

	+observer loggedIn
	onLoggedInChange: ->
		if @loggedIn
			Ember.$.ajaxSetup {data: {"token": localStorage['fbtoken']}}
			@setPusher
			@getActiveStatus()
			@setinternetConnectionListeners
		else 
			return #need logout code

	setInitialLoggedIn: ->
		if localStorage.fbtoken? then return true else return false

	setClientLoggedInStatus: ->
		console.log "setClientLoggedInStatus"
		if localStorage.fbtoken? then @loggedIn = true else @loggedIn = false

	## LOCATION

	# This is only a setup function. The currentLocation will always be up-to-date after init from watchPosition()
	getLocation: ->
		Ember.run.begin()
		console.log "getLocation"
		navigator.geolocation.getCurrentPosition( (position) => @currentLocation = position,null,{timeout:0,maximumAge:Infinity,enableHighAccuracy:true})
		Ember.run.end()

	setInitialLocation: ->
		currentLocation = null
		navigator.geolocation.getCurrentPosition( (position) -> 
			@currentLocation = position
			null
			{timeout:0,maximumAge:Infinity,enableHighAccuracy:true})
		return currentLocation


	sendLocation: ->
		Ember.$.ajax 
			url: "http://damp-sea-6022.herokuapp.com/locations/update.json"
			data: 
				timestamp: @currentLocation.timestamp
				latitude: @currentLocation.coords.latitude
				longitude: @currentLocation.coords.longitude
				accuracy: @currentLocation.coords.accuracy

	setInterval: ->
		app = this
		`setInterval(function(){app.sendLocation()},60000);`

	# INTERNET CONNECTION

	setInitialInternetConnection: ->
		return true

	setinternetConnectionListeners: ->
		if cordova?
			document.addEventListener("online", @onOnline, false)
			document.addEventListener("offline", @onOffline, false)
		else
			@internetConnection = true

	onOnline: -> 
		Ember.run.begin()
		@internetConnection = true
		document.addEventListener("online", @onOnline, false)
		Ember.run.end()


	onOffline: ->
		Ember.run.begin()
		@internetConnection = true
		document.addEventListener("offline", @onOffline, false)
		Ember.run.end()

	## UTILITIES

	login: ->
		window.plugins.spinnerDialog.show() if cordova?
		openFB.login 'email,user_photos,user_birthday', => 
			Ember.$.ajax
				url: 'http://damp-sea-6022.herokuapp.com/users/login.json'
				data: {token: localStorage['fbtoken']}
				success: (response) =>
					Ember.run.begin()
					localStorage['fbtoken'] = response
					@setClientLoggedInStatus()
					window.plugins.spinnerDialog.hide() if cordova?
					@transitionToRoute 'map'
					Ember.run.end()
				dataType: "text"

	join: ->
		Ember.$.ajax 
			url: "http://damp-sea-6022.herokuapp.com/hunts/join.json"
			success: (response) => @setActiveStatus(response)
			dataType: "text"

	setPusher: ->
		pusher = new Pusher '0750760773b8ed5ae1dc'
		channel = pusher.subscribe localStorage['fbtoken']
		channel.bind 'updatelocation', => Ember.run.bind this, @send 'updatelocation'

`export default ApplicationController`