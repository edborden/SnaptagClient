`import MeMapView from 'appkit/views/me-map'`

class ZoneCircle extends EmberLeaflet.CircleLayer
	contentBinding: 'controller.content.zone'
	options:
		fill: false
		weight: 2
		opacity: 1
		color: "black"

themIcon = L.AwesomeMarkers.icon
    icon: 'crosshairs'
    markerColor: 'darkred'
    prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContentBinding: 'content.popupContent'

class MarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller.content.users'
	itemLayerClass: ThemMarker

class IntroMapView extends MeMapView
	init: ->
		@_super()
		@childLayers.push MarkersLayer, ZoneCircle

`export default IntroMapView`