class ApplicationController extends Ember.ObjectController
	currentLocation: null
	topNav: true

	init: ->
		navigator.geolocation.watchPosition(@handle_watch_response,null, {enableHighAccuracy:true})
		window.setInterval(navigator.geolocation.getCurrentPosition(@handle_get_response),10000)
		window.thing = this

	handle_get_response: (position) ->  
		@currentLocation = position
		console.log "getresponse"

	handle_watch_response: (position) ->  
		@currentLocation = position
		console.log "watchresponse"

	+observer currentLocation
	currentLocationChanged: ->
		console.log @currentLocation
		console.log "currentLocationChanged"

	locationChanged: ->
		(console.log "locationchanged").observes('currentLocation')

`export default ApplicationController`