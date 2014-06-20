`import TileLayer from 'appkit/lib/tile-layer'`
`import MeCircle from 'appkit/lib/me-circle'`
`import MeMarker from 'appkit/lib/me-marker'`
`import ZoneCircles from 'appkit/lib/zone-circles'`
`import TargetClusters from 'appkit/lib/target-clusters'`
`import CenterMap from 'appkit/mixins/center-map'`

latestIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'darkblue'
	prefix: 'fa'

class LatestMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: latestIcon}
	popupContent: ~> return @content.popupContent

class LatestMarkers extends EmberLeaflet.MarkerCollectionLayer
	content: ~> return @controller.latestLocations
	itemLayerClass: LatestMarker

class TargetMapView extends EmberLeaflet.MapView with CenterMap
	classNames: ['stacked']
	currentLocation: ~> return @controller.session.currentLocation
	childLayers: [TileLayer,MeCircle,MeMarker,ZoneCircles,TargetClusters,LatestMarkers]
	options:
		zoomControl:false
		attributionControl:false

	didCreateLayer: ->
		@_super()
		if @controller.latestLocationsArray?
			markerarray = [@childLayers[2].content.location, @childLayers[5].childLayers.map (marker) -> marker.content.location]
			@centerMap(markerarray,@_layer)
		else
			@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)

	+observer controller.targetContent
	onTargetContentChange: ->
		markerarray = [@childLayers[2].content.location, @controller.latestLocations.map (item) -> item.location]
		unless @controller.targetContent is null
			markerarray.push @controller.targetContent.map (item) -> item.location
		@centerMap(markerarray,@_layer)

	+observer controller.latestLocations
	onLatestLocationsChange: ->
		markerarray = [@childLayers[2].content.location, @controller.latestLocations.map (item) -> item.location]
		unless @controller.targetContent is null
			markerarray.push @controller.targetContent.map (item) -> item.location
		@centerMap(markerarray,@_layer)

`export default TargetMapView`