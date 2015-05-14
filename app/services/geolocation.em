class GeolocationService extends Ember.Service

	currentLocationObject: null

	lat: ~> @currentLocationObject.coords.latitude
	lng: ~> @currentLocationObject.coords.longitude
	accuracy: ~> @currentLocationObject.coords.accuracy

	location: ~> L.latLng @lat, @lng
	object: ~> {lat:@lat,lng:@lng}
	array: ~> [@lat,@lng]

	setupLocation: ->
		return new Ember.RSVP.Promise (resolve) =>
			navigator.geolocation.watchPosition (position) => @currentLocationObject = position,null, {enableHighAccuracy:true}
			navigator.geolocation.getCurrentPosition( (position) => 
				@currentLocationObject = position
				resolve()
				null
				{timeout:1000,maximumAge:Infinity,enableHighAccuracy:true}
			)
`export default GeolocationService`