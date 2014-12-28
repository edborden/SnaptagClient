themIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'green'
	prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContent: ~> return @content.popupContent

class TargetMarkers extends EmberLeaflet.MarkerCollectionLayer
	content: ~> return @controller.targetHistoryLocations
	itemLayerClass: ThemMarker

class TargetClusters extends EmberLeaflet.ContainerLayer
	childLayers: [TargetMarkers]
	_newLayer: ->
		new L.MarkerClusterGroup({maxClusterRadius:60})

`export default TargetClusters`