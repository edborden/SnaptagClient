`import ServerTalk from 'appkit/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	model: ->
		Ember.$.ajaxSetup {data: {"token": localStorage.fbtoken}} if localStorage.fbtoken? 
		Ember.RSVP.hash
			currentLocation: @setInitialLocation()
			internetConnection: @setInitialInternetConnection()
			loggedIn: @setInitialLoggedIn()
			active: @setInitialActive()
			queue: @setInitialQueue()

	afterModel: (model) ->
		@session.setProperties model
		navigator.geolocation.watchPosition( (position) => @session.currentLocation = position,null, {enableHighAccuracy:true})
		@_super()

	setupController: ->
		return  # don't want to set the model in the controller, messes up downstream controllers for some reason

	actions:
		updatelocation: ->
			console.log "UPDATELOCATION EVENT"
		back: ->
			window.history.go(-1)
		login: ->
			window.plugins.spinnerDialog.show() if cordova?
			openFB.login 'email,user_photos,user_birthday', =>
				@getServer("users/login",{token: localStorage.fbtoken}).then( (response) => 
					localStorage['fbtoken'] = response
					@session.loggedIn = true
					window.plugins.spinnerDialog.hide() if cordova?
					@transitionTo 'map')
		join: ->
			window.plugins.spinnerDialog.show() if cordova?
			@getServer("hunts/join",{timestamp: @session.currentLocation.timestamp,latitude: @session.currentLocation.coords.latitude,longitude: @session.currentLocation.coords.longitude,accuracy: @session.currentLocation.coords.accuracy}).then (response) =>
				if response is 'active'
					@session.active = true 
					Bootstrap.GNM.push('Sleeper Activated.', 'You are now in-game.', 'success')
				if response is 'queue'
					@session.queue = true 
					Bootstrap.GNM.push('Queue entered.', 'You are waiting to play.', 'success')
				window.plugins.spinnerDialog.hide() if cordova?
				@replaceWith 'map' if @session.active

		unjoin: ->
			@session.queue = false

	## INIT

	setInitialQueue: ->
		if localStorage.fbtoken?
			@getServer("users/status").then (response) ->
				if response is 'queue' then return true else return false				
		else
			return false

	setInitialActive: ->
		if localStorage.fbtoken?
			@getServer("users/status").then (response) ->
				if response is 'active' then return true else return false
		else
			return false

	setInitialLocation: ->
		return new Ember.RSVP.Promise (resolve) => 
			navigator.geolocation.getCurrentPosition (response) -> resolve response,null,{timeout:1000,maximumAge:Infinity,enableHighAccuracy:true}

	setInitialLoggedIn: ->
		if localStorage.fbtoken? then return true else return false

	setInitialInternetConnection: ->
		return true

`export default ApplicationRoute`