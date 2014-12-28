class LocService extends Ember.Object

	currentLocationObject: null

	lat: ~> @currentLocationObject.coords.latitude
	lng: ~> @currentLocationObject.coords.longitude
	accuracy: ~> @currentLocationObject.coords.accuracy

	object: ~> {lat:@lat,lng:@lng}
	array: ~> [@lat,@lng]

	setupLocation: ->
		return new Ember.RSVP.Promise (resolve) =>
			navigator.geolocation.watchPosition (position) => @currentLocationObject = position,null, {enableHighAccuracy:true}
			navigator.geolocation.getCurrentPosition (position) => 
				@currentLocationObject = position
				resolve()
				null
				{timeout:1000,maximumAge:Infinity,enableHighAccuracy:true}

`export default LocService`