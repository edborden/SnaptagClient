class Session extends Ember.Object

	loggedIn: ~> if @model? then return true else return false
	model: null
	token: ~> if @model? then return @model.token else return null
	me: Ember.computed.alias 'model.user'
	hasInternetConnection: true
	locationIsAccurate: ~>
		if cordova?
			if @currentLocation.coords.accuracy < 100 then return true else return false
		else 
			return true
	currentLocation: null
	location: ~> L.latLng @currentLocation.coords.latitude, @currentLocation.coords.longitude
	isTransmitting: ~> if @active and @locationIsAccurate and @hasInternetConnection then return true else return false
	
	active: ~> if @me.status? and @me.status is 'active' then return true else return false
	queue: ~> if @me.status? and @me.status is 'queue' then return true else return false
	inactive: ~> if @me.status? and @me.status is 'inactive' then return true else return false

	open: (token) ->
		@store.find('session', {token: token}).then( 
			(response) => 
				@model = response.objectAt(0)
			(error) -> localStorage.clear() if error.status is 401
		)

	post: (token) ->
		@store.createRecord('session',{token: token}).save().then( 
			(response) => 
				@model = response
				localStorage.fbtoken = @token
			(error) -> localStorage.clear() if error.status is 401
		)

	close: ->
		openFB.logout()
		@model = null

	pusher: null
	mapController: null
	mapUi: null

	+observer me.status
	setPusher: ->
		Ember.run.next @, =>
			if @model?
				console.log 'setpusher'
				@pusher.disconnect() if @pusher? and @inactive
				@pusher = new Pusher '0750760773b8ed5ae1dc' unless @pusher?
				if @queue
					console.log 'queue subscriptions'
					return # real-time queue sync here
				if @active
					channel = @pusher.subscribe @me.id
					channel.bind 'new_target', (data) =>
						@store.pushPayload data
						user = @store.getById 'user', data.user.id
						@me.suspects.pushObject user
						@me.targets.pushObject user
						user.notifyPropertyChange 'isTarget'
					channel.bind 'remove_suspect', (data) =>
						user = @store.getById 'user', data
						if @mapUi.modal?
							modal = @mapUi.modal
							@mapUi.activeSuspect = null if @mapUi.activeSuspect.id is data
							@mapUi.modal = null
						@me.suspects.removeObject user
						Ember.run.next @, => @mapUi.modal = modal if modal?
					@me.suspects.forEach (suspect) =>
						channel = @pusher.subscribe suspect.id
						channel.bind 'remove', (data) => 
							user = @store.getById 'user', data
							@me.suspects.removeObject user
							@me.targets.removeObject user
						if suspect.isTarget
							channel.bind 'location', (data) =>
								@store.pushPayload data
								location = @store.getById 'location', data.location.id
								suspect.locations.pushObject location
								suspect.notifyPropertyChange 'latestLocation'
								@mapController.notifyPropertyChange 'latestLocations'
			#	channel = pusher.subscribe "tables"
			#	channel.bind 'remove', (id) => 
			#		table = @store.getById 'table', id
			#		table.deleteRecord() if table
			else
				@pusher.disconnect() if @pusher?

	## LOGGED IN

	+observer model
	loggedInChanged: ->
		if @model?
			@setInternetConnectionListeners()
			@transmittingChanged()

	## TRANSMITTING

	intervalID: null

	+observer isTransmitting
	transmittingChanged: ->
		if @isTransmitting and !@intervalID?
			@intervalID = @setLocationInterval()
		if @isTransmitting is false and @intervalID
			clearInterval @intervalID
			@intervalID = null

	sendLocation: ->
		@store.createRecord('location',{lat: @currentLocation.coords.latitude,lng: @currentLocation.coords.longitude}).save()
		@me.stealth = @me.stealth + 1

	setLocationInterval: ->
		app = this
		`setInterval(function(){app.sendLocation()},60000);`

	## INTERNET CONNECTION

	setInternetConnectionListeners: ->
		if cordova?
			document.addEventListener("online", @onOnline, false)
			document.addEventListener("offline", @onOffline, false)
		else
			@hasInternetConnection = true

	onOnline: -> 
		@hasInternetConnection = true
		document.addEventListener("online", @onOnline, false)

	onOffline: ->
		@hasInternetConnection = false
		document.addEventListener("offline", @onOffline, false)

	## LOCATION

	setupLocation: ->
		return new Ember.RSVP.Promise (resolve) =>
			navigator.geolocation.watchPosition( (position) => @currentLocation = position,null, {enableHighAccuracy:true})
			navigator.geolocation.getCurrentPosition((position) => 
				@currentLocation = position
				resolve position
				null
				{timeout:1000,maximumAge:Infinity,enableHighAccuracy:true}
			)

`export default Session`