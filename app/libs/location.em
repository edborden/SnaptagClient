class Location
	init: ->
		@_super()
		navigator.geolocation.getCurrentPosition(@handle_geolocation_response)
		navigator.geolocation.watchPosition(@handle_geolocation_response,null, {enableHighAccuracy:true})
		
	handle_geolocation_response: (position) ->  
		@current = position
		console.log @current

	updateCurrent: ->
		navigator.geolocation.getCurrentPosition @handle_geolocation_response
		console.log @current

`export default Location`