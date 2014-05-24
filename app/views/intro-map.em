`import MeMapView from 'appkit/views/me-map'`

class ZoneCircle extends EmberLeaflet.CircleLayer
	content: {location: L.latLng(40.865286, -74.417388),radius: 10000}
	options:
		fill: false
		weight: 3
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