class MeLayer extends EmberLeaflet.Layer

	geolocation:Ember.inject.service()

	_newLayer: ->
		L.userMarker @geolocation.array, {accuracy:@geolocation.accuracy, smallIcon:true, pulsing:true}

	+observer geolocation.currentLocationObject
	onLocationChange: ->
		@_layer.setLatLng @geolocation.array
		@_layer.setAccuracy @geolocation.accuracy

`export default MeLayer`