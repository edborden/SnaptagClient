themIcon = L.AwesomeMarkers.icon
    icon: 'crosshairs'
    markerColor: 'green'
    prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContentBinding: 'content.popupContent'

class MarkersLayer extends EmberLeaflet.CollectionLayer
	contentBinding: 'controller.content.users'
	itemLayerClass: ThemMarker

class ThemClusters extends EmberLeaflet.ContainerLayer
	childLayers: [MarkersLayer]
	_newLayer: ->
		new L.MarkerClusterGroup({maxClusterRadius:60})

`export default ThemClusters`