`import MeMapView from 'appkit/views/me-map'`

latestIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'orange'
	prefix: 'fa'

class LatestMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: latestIcon}
	contentBinding: 'controller.content.user.latestLocation'
	popupContentBinding: 'content.popupContent'

themIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'darkred'
	prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContentBinding: 'content.popupContent'

class TargetMarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller.content.user.locations'
	itemLayerClass: ThemMarker

class ClusterLayer extends EmberLeaflet.ContainerLayer
	childLayers: [TargetMarkersLayer]
	_newLayer: ->
		new L.MarkerClusterGroup({maxClusterRadius:60})

class TargetsMapView extends MeMapView
	init: ->
		@_super()
		@childLayers.push ClusterLayer,LatestMarker

`export default TargetsMapView`