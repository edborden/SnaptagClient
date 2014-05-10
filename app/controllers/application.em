`import ServerTalk from 'appkit/mixins/server-talk'`

class ApplicationController extends Ember.ObjectController with ServerTalk

	intervalID: null	

	## TRANSMITTING

	+observer session.transmitting
	transmittingChanged: ->
		if @session.transmitting and @intervalID?
			@intervalID = @setInterval()
		if @session.transmitting is false and @intervalID
			clearInterval(@intervalID)
			@intervalID = null

	sendLocation: ->
		getServer "locations/update",
			data: 
				timestamp: @currentLocation.timestamp
				latitude: @currentLocation.coords.latitude
				longitude: @currentLocation.coords.longitude
				accuracy: @currentLocation.coords.accuracy

	setInterval: ->
		app = this
		`setInterval(function(){app.sendLocation()},60000);`

	## INTERNET CONNECTION

	setInternetConnectionListeners: ->
		if cordova?
			document.addEventListener("online", @onOnline, false)
			document.addEventListener("offline", @onOffline, false)
		else
			@session.internetConnection = true

	onOnline: -> 
		Ember.run.begin
		@session.internetConnection = true
		document.addEventListener("online", @onOnline, false)
		Ember.run.end


	onOffline: ->
		Ember.run.begin
		@session.internetConnection = false
		document.addEventListener("offline", @onOffline, false)
		Ember.run.end

	## LOGGED IN

	loggedInChanged: ~>
		if @session.loggedIn 
			Ember.$.ajaxSetup {data: {"token": localStorage.fbtoken}}
			@setPusher
			@getServer("users/status").then @session.setActiveStatus response
			@setInternetConnectionListeners
		else
			return #put logout code here

	setPusher: ->
		pusher = new Pusher '0750760773b8ed5ae1dc'
		channel = pusher.subscribe localStorage['fbtoken']
		channel.bind 'updatelocation', => Ember.run.bind this, @send 'updatelocation'

`export default ApplicationController`