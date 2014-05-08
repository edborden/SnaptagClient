class ApplicationRoute extends Ember.Route

#	setupController: (controller,model) ->
#		controller.test2 = model.test1


	model: ->
		Ember.RSVP.hash
			currentLocation: @setInitialLocation()
			active: @setInitialActive()
			queue: @setInitialQueue()
			loggedIn: @setInitialLoggedIn()
			internetConnection: @setInitialInternetConnection()

	afterModel: ->
		@_super()
		console.log @currentModel
#		if @controllerFor('application').loggedIn is false then @replaceWith('index')
#		@_super()

	actions:
		updatelocation: ->
			console.log "UPDATELOCATION EVENT"
		back: ->
			window.history.go(-1)

	## INIT

	setInitialActive: ->
		if localStorage.fbtoken?
			active = null
			Ember.$.ajax 
				url: "http://damp-sea-6022.herokuapp.com/users/status.json"
				success: (response) -> 
					if response is 'active' then @active = true else @active = false
				dataType: "text"
			return active
		else
			return false

	setInitialQueue: ->
		if localStorage.fbtoken?
			queue = null
			Ember.$.ajax 
				url: "http://damp-sea-6022.herokuapp.com/users/status.json"
				success: (response) -> 
					if response is 'queue' then @queue = true else @queue = false
				dataType: "text"
			return queue
		else
			return false

	setInitialLocation: ->
		console.log "setInitialLocation"
		currentLocation = null
		navigator.geolocation.getCurrentPosition( (position) -> 
			Ember.run.begin()
			console.log position
			@currentLocation = position
			Ember.run.end()
			null
			{timeout:0,maximumAge:Infinity,enableHighAccuracy:true})
		return currentLocation

	setInitialLoggedIn: ->
		if localStorage.fbtoken? then return true else return false

	setInitialInternetConnection: ->
		return true

`export default ApplicationRoute`