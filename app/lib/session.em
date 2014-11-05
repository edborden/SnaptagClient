class Session extends Ember.Object

	loggedIn: ~> if @model? then return true else return false
	model: null
	token: ~> if @model? then return @model.token else return null
	me: ~> @model.user
	hasInternetConnection: true
	locationIsAccurate: ~>
		if cordova?
			if @currentLocation.coords.accuracy < 100 then return true else return false
		else 
			return true
	currentLocation: null
	location: ~> L.latLng @currentLocation.coords.latitude, @currentLocation.coords.longitude
	isTransmitting: ~> if @active and @locationIsAccurate and @hasInternetConnection then return true else return false
	active: ~> if @model? && @me.status is 'active' then return true else return false
	queue: ~> if @model? && @me.status is 'queue' then return true else return false

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


	#+observer model
	#onModelChange: ->
	#	pusher = new Pusher '582c7172c76f25330f7f'
	#	channel = pusher.subscribe "c"+@me.id.toString()
	#	channel.bind 'notification', (data) => 
	#		@store.pushPayload data
	#		notification = @store.getById 'notification', data.notification.id
	#		@me.notifications.unshiftObject notification
	#		@me.notifyPropertyChange 'unreadNotifications'
	#	channel = pusher.subscribe "tables"
	#	channel.bind 'remove', (id) => 
	#		table = @store.getById 'table', id
	#		table.deleteRecord() if table
	#	channel.bind 'update', (data) =>
	#		@store.pushPayload data
	#		table = @store.getById 'table', data.table.id
	#		table.restaurant.tables.pushObject table

	## LOGGED IN

	+observer model
	loggedInChanged: ->
		if @loggedIn
			@setPusher()
			@setInternetConnectionListeners()
			@transmittingChanged()

	setPusher: ->
		pusher = new Pusher '0750760773b8ed5ae1dc'
		channel = pusher.subscribe localStorage['fbtoken']
		channel.bind 'updatelocation', => Ember.run.bind this, @send 'updatelocation'

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
		@store.createRecord('location',{lat: @currentLocation.coords.latitude,lon: @currentLocation.coords.longitude}).save()

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