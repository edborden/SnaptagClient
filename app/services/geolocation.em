class GeolocationService extends Ember.Service

	init: ->
		@setupLocation()

	currentLocationObject: 
		coords:
			latitude: 0
			longitude: 0
			accuracy: 9999

	lat: ~> @currentLocationObject.coords.latitude
	lng: ~> @currentLocationObject.coords.longitude
	accuracy: ~> @currentLocationObject.coords.accuracy

	location: ~> L.latLng @lat, @lng
	object: ~> {lat:@lat,lng:@lng}
	array: ~> [@lat,@lng]

	setupLocation: ->
		success = Ember.run.bind @,@success
		navigator.geolocation.watchPosition success,@error, {enableHighAccuracy:true}
		navigator.geolocation.getCurrentPosition success,@error,{timeout:1000,maximumAge:Infinity,enableHighAccuracy:true}

	success: (position) ->
		@currentLocationObject = position

	error: (error) ->
		console.warn('LOCATION ERROR(' + error.code + '): ' + error.message)

`export default GeolocationService`