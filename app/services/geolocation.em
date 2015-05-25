class GeolocationService extends Ember.Service

	success: false

	init: ->
		@setupLocation()

	currentLocationObject: null

	lat: ~> @currentLocationObject.coords.latitude if @currentLocationObject
	lng: ~> @currentLocationObject.coords.longitude if @currentLocationObject
	accuracy: ~> @currentLocationObject.coords.accuracy if @currentLocationObject

	location: ~> L.latLng @lat, @lng if @currentLocationObject
	object: ~> {lat:@lat,lng:@lng} if @currentLocationObject
	array: ~> [@lat,@lng] if @currentLocationObject

	setupLocation: ->
		firstPositionSuccess = Ember.run.bind @,@firstPositionSuccess
		setPosition = Ember.run.bind @,@setPosition

		navigator.geolocation.watchPosition setPosition,@error, {enableHighAccuracy:true}
		navigator.geolocation.getCurrentPosition firstPositionSuccess,@error,{timeout:15000,maximumAge:0,enableHighAccuracy:true}

	setPosition: (position) ->
		@currentLocationObject = position

	firstPositionSuccess:  (position) ->
		@setPosition position
		console.log 'LOCATION SUCCESS'
		@success = true

	error: (error) ->
		console.warn('LOCATION ERROR(' + error.code + '): ' + error.message)

`export default GeolocationService`