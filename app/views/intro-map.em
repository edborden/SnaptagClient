`import MeMapView from 'appkit/views/me-map'`

themIcon = L.AwesomeMarkers.icon
    icon: 'crosshairs'
    markerColor: 'darkred'
    prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContent: "Active Sleeper has exposed 25 total targets and has been hunting for the past 2 days and 36 minutes."

class MarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller'
	itemLayerClass: ThemMarker

class IntroMapView extends MeMapView
	init: ->
		@_super()
		@childLayers.push MarkersLayer

`export default IntroMapView`