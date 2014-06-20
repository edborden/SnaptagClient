themIcon = L.AwesomeMarkers.icon
    icon: 'crosshairs'
    markerColor: 'green'
    prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContent: ~> return @content.inactiveMapPopupContent

class MarkersLayer extends EmberLeaflet.CollectionLayer
	content: ~> return @controller.content.content
	itemLayerClass: ThemMarker

class ThemClusters extends EmberLeaflet.ContainerLayer
	childLayers: [MarkersLayer]
	_newLayer: ->
		new L.MarkerClusterGroup({maxClusterRadius:60})

`export default ThemClusters`