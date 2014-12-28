themIcon = L.AwesomeMarkers.icon
    icon: 'crosshairs'
    markerColor: 'darkred'
    prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContent: ~> @content.inactiveMapPopupContent

class MarkersLayer extends EmberLeaflet.CollectionLayer
	content: ~> @_parentLayer.content.users
	itemLayerClass: ThemMarker

class ThemClusters extends EmberLeaflet.ContainerLayer
	childLayers: [MarkersLayer]
	_newLayer: ->
		new L.MarkerClusterGroup {maxClusterRadius:60}

`export default ThemClusters`