class TransmitService extends Ember.Service
	store: Ember.inject.service()
	session: Ember.inject.service()
	geolocation: Ember.inject.service()

	init: -> 
		@transmittingChanged()
		#@setInternetConnectionListeners()

	hasInternetConnection: true#false

	locationIsAccurate: ~>
		if cordova? then @geolocation.accuracy < 100 else true

	isTransmitting: ~> @session.active and @locationIsAccurate and @hasInternetConnection

	intervalID: null

	+observer isTransmitting
	transmittingChanged: ->
		console.log 'transmittingChanged',@isTransmitting
		console.log @session.active, @locationIsAccurate, @hasInternetConnection
		if @isTransmitting and not @intervalID?
			@intervalID = @setLocationInterval()
		if @isTransmitting is false and @intervalID
			console.log 'clearInterval'
			clearInterval @intervalID
			@intervalID = null

	sendLocation: ->
		console.log 'sendLocation'
		@store.createRecord('location',@geolocation.object).save()
		@session.me.stealth = @session.me.stealth + 1

	setLocationInterval: ->
		console.log 'setLocationInterval'
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
		console.log "internet connection went online"
		unless @hasInternetConnection
			@hasInternetConnection = true
			document.addEventListener("online", @onOnline, false)

	onOffline: ->
		console.log "inernet connection went offline"
		if @hasInternetConnection
			@hasInternetConnection = false
			document.addEventListener("offline", @onOffline, false)

`export default TransmitService`