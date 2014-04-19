Location = Ember.Object.extend(
	currentVal: null
	init: ->
		@_super()
		navigator.geolocation.getCurrentPosition(@handle_geolocation_response)
		navigator.geolocation.watchPosition(@handle_geolocation_response,null, {enableHighAccuracy:true})
		
	handle_geolocation_response: (position) ->  
		console.log position.coords.latitude, position.coords.longitude, position.coords.accuracy, position.timestamp
		console.log @currentVal

	updateCurrent: ->
		navigator.geolocation.getCurrentPosition(@handle_geolocation_response)
)

`export default Location`