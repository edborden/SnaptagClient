class MeLayer extends EmberLeaflet.Layer

	currentLocation: ~> @controller.session.currentLocation

	_newLayer: ->
		L.userMarker [@currentLocation.coords.latitude, @currentLocation.coords.longitude], {accuracy:@currentLocation.coords.accuracy, smallIcon:true, pulsing:true}

	+observer currentLocation
	onLocationChange: ->
		@_layer.setLatLng [@currentLocation.coords.latitude, @currentLocation.coords.longitude]
		@_layer.setAccuracy @currentLocation.coords.accuracy

`export default MeLayer`