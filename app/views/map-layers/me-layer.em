class MeLayer extends EmberLeaflet.Layer

	loc: ~> @controller.loc

	_newLayer: ->
		L.userMarker @loc.array, {accuracy:@loc.accuracy, smallIcon:true, pulsing:true}

	+observer loc.currentLocationObject
	onLocationChange: ->
		@_layer.setLatLng @loc.array
		@_layer.setAccuracy @loc.accuracy

`export default MeLayer`