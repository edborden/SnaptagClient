class TransmitService extends Ember.Service
	store: Ember.inject.service()
	session: Ember.inject.service()
	init: -> @setInternetConnectionListeners()

	active: ~> @session.active

	hasInternetConnection: true

	locationIsAccurate: ~>
		if cordova?
			if @loc.accuracy < 100 then return true else return false
		else 
			return true

	isTransmitting: ~> if @active and @locationIsAccurate and @hasInternetConnection then return true else return false

	intervalID: null

	+observer isTransmitting
	transmittingChanged: ->
		if @isTransmitting and !@intervalID?
			@intervalID = @setLocationInterval()
		if @isTransmitting is false and @intervalID
			clearInterval @intervalID
			@intervalID = null

	sendLocation: ->
		@store.createRecord('location',@loc.formatted).save()
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

`export default TransmitService`