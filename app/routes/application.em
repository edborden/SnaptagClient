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
			openFB.login 'email,user_photos,user_birthday', =>
				@getServer("users/login",{token: localStorage.fbtoken},"json").then( (response) => 
					localStorage['fbtoken'] = response.token
					@session.loggedIn = true
					if response.status is "inactive"
						@transitionTo 'inactivemap'
						Bootstrap.GNM.push 'Logged In', 'You may now Activate.', 'success'
					else if response.status is "queue"
						@session.queue = true
						@transitionTo 'map'
						Bootstrap.GNM.push 'Logged In', 'You are waiting for other Sleepers.', 'success'
					else
						@session.active = true
						@transitionTo 'map'
						Bootstrap.GNM.push 'Logged In', 'You are now in-game.', 'success')
		join: ->
			@getServer("hunts/join",{lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude}).then (response) =>
				if response is 'active'
					@session.active = true 
					Bootstrap.GNM.push 'Sleeper Activated.', 'You are now in-game.', 'success'
				if response is 'queue'
					@session.queue = true 
					Bootstrap.GNM.push 'Queue entered.', 'You are waiting to play.', 'success'
				@replaceWith 'map' if @session.active
		logout: ->
			localStorage.clear()
			@session.loggedIn = false
			@session.active = false
			@replaceWith 'index'
			Bootstrap.GNM.push('Logged Out', null, 'success')
		unjoin: ->
			@session.queue = false
		expose: (user) ->
			@getServer('hunts/expose', {target_id: user.id}).then( (response) =>
				Bootstrap.GNM.push 'Success', 'Target Exposed.', 'success'
				@modelFor('hunt').reload() if @modelFor('hunt')?
				@modelFor('map').reload() if @modelFor('map')?
				@replaceWith 'hunt')
		leave_game: ->
			return
		counteract: (user) ->
			@getServer('hunts/counteract', {hunter_id: user.id}).then( (response) =>
				if response is "success"
					Bootstrap.GNM.push 'Success', 'Hunter compromised.', 'success'
					@replaceWith 'hunt'
				else
					@session.active = false
					Bootstrap.GNM.push 'Disavowed', 'Counteraction unsuccessful.', 'warning'
					@replaceWith 'inactivemap')

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