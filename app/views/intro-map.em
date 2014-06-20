`import TileLayer from 'appkit/lib/tile-layer'`
`import MeCircle from 'appkit/lib/me-circle'`
`import MeMarker from 'appkit/lib/me-marker'`
`import ThemClusters from 'appkit/lib/them-clusters'`

class IntroMapView extends EmberLeaflet.MapView
	classNames: ['stacked']
	currentLocation: Ember.computed.alias "controller.session.currentLocation"
	childLayers: [TileLayer,MeCircle,MeMarker,ThemClusters]
	options:
		zoomControl:false
		attributionControl:false

	didCreateLayer: ->
		@_super()
		$ ->
			$(".typed").typed
				strings: ["You ^400 are ^500 being ^400 watched."]
				typeSpeed: 50
		@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)
		@childLayers[2].openPopup()
		markerarray = @childLayers[3].childLayers[0].childLayers.map (marker) -> marker.content.location
		bounds = L.latLngBounds(markerarray)
		@_layer.fitBounds(bounds)

`export default IntroMapView`