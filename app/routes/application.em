`import ServerTalk from 'appkit/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	model: ->
		Ember.RSVP.hash
			currentLocation: @setInitialLocation()
			active: @getInitialStatus().then parseActive response
			queue: @getInitialStatus().then parseQueue response
			loggedIn: @setInitialLoggedIn()
			internetConnection: @setInitialInternetConnection()

	setupController: (controller,model) ->
		controller.model = null
		@session.setProperties model
		navigator.geolocation.watchPosition( (position) => @currentLocation = position,null, {enableHighAccuracy:true})
		@replaceWith 'index' unless model.loggedIn

	actions:
		updatelocation: ->
			console.log "UPDATELOCATION EVENT"
		back: ->
			window.history.go(-1)
		login: ->
			@fbLogin().then(getServer("users/login",data:{token:localStorage.fbtoken})).then onLogin newtoken
		join: ->
			@getServer("hunts/join",
				data: {location: @session.currentLocation}
			).then @session.setActiveStatus response

	onLogin: (newtoken) ->
		localStorage['fbtoken'] = newtoken
		@session.loggedIn = true

	fbLogin: ->
		return new Promise (resolve,reject) ->
			openFB.login 'email,user_photos,user_birthday'

	## INIT

	parseQueue: (response) ->
		if response is 'queue' then return true else return false

	parseActive: (response) ->
		if response is 'active' then return true else return false

	getInitialStatus: ->
		getServer "users/status" if localStorage.fbtoken? else return false

	setInitialLocation: ->
		return new Promise (resolve,reject) -> 
			navigator.geolocation.getCurrentPosition (position) -> resolve position
			null
			{timeout:0,maximumAge:Infinity,enableHighAccuracy:true}

	setInitialLoggedIn: ->
		if localStorage.fbtoken? then return true else return false

	setInitialInternetConnection: ->
		return true

`export default ApplicationRoute`