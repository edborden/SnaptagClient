themIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'green'
	prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContentBinding: 'content.popupContent'

class TargetMarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	content: ~> return @controller.targetContent.locations
	itemLayerClass: ThemMarker

class TargetClusters extends EmberLeaflet.ContainerLayer
	childLayers: [TargetMarkersLayer]
	_newLayer: ->
		new L.MarkerClusterGroup({maxClusterRadius:60})

`export default TargetClusters`