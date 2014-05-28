`import ServerTalk from 'appkit/mixins/server-talk'`

class ApplicationController extends Ember.ObjectController with ServerTalk

	intervalID: null

	## NAV HELPERS

	isPicRoute: Ember.computed.equal 'currentRouteName', 'pic'
	isIndexRoute: Ember.computed.equal 'currentRouteName', 'index'
	isInactivemapRoute: Ember.computed.equal 'currentRouteName', 'inactivemap'
	isHuntUserRoute: Ember.computed.equal 'currentRouteName', 'hunt.user'
	isHuntTargetRoute: Ember.computed.equal 'currentRouteName', 'hunt.target'
	isMapRoute: Ember.computed.equal 'currentRouteName', 'map'

	isBackButtonRoute: ~>
		switch @currentRouteName
			when "pic" then return true
			when "hunt.expose" then return true
			when "hunt.counteract" then return true
			else return false

	## BACK BUTTON

	currentMapRoute: ~>
		if @session.active then return "map" else return "inactivemap"

	init: ->
		@_super()
		document.addEventListener "backbutton", => 
			switch @currentRouteName
				when "index" then navigator.app.exitApp()
				when "inactivemap" then navigator.app.exitApp()
				when "map" then navigator.app.exitApp()
				when "hunt.index" then @transitionToRoute "map"
				when "me" then @transitionToRoute @currentMapRoute
				when "world" then @transitionToRoute @currentMapRoute
				else window.history.go(-1)		

	## TRANSMITTING

	+observer session.transmitting
	transmittingChanged: ->
		if @session.transmitting and !@intervalID?
			@intervalID = @setLocationInterval()
		if @session.transmitting is false and @intervalID
			clearInterval @intervalID
			@intervalID = null

	sendLocation: ->
		@getServer "locations/update",
			timestamp: @session.currentLocation.timestamp
			lat: @session.currentLocation.coords.latitude
			lon: @session.currentLocation.coords.longitude
			accuracy: @session.currentLocation.coords.accuracy

	setLocationInterval: ->
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

	+observer session.loggedIn
	loggedInChanged: ->
		if @session.loggedIn 
			Ember.$.ajaxSetup {data: {"token": localStorage.fbtoken}}
			@setPusher
			@getServer("users/status").then (response) =>
				@session.active = true if response is 'active'
				@session.queue = true if response is 'queue'
			@setInternetConnectionListeners
		else
			return #put logout code here

	setPusher: ->
		pusher = new Pusher '0750760773b8ed5ae1dc'
		channel = pusher.subscribe localStorage['fbtoken']
		channel.bind 'updatelocation', => Ember.run.bind this, @send 'updatelocation'

`export default ApplicationController`