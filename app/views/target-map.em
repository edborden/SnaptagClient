`import TileLayer from 'appkit/lib/tile-layer'`
`import MeCircle from 'appkit/lib/me-circle'`
`import MeMarker from 'appkit/lib/me-marker'`
#`import ZoneCircles from 'appkit/lib/zone-circles'`
`import TargetClusters from 'appkit/lib/target-clusters'`
`import CenterMap from 'appkit/mixins/center-map'`

latestIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'darkblue'
	prefix: 'fa'

class LatestMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: latestIcon}
	popupContent: ~> @content.popupContent

class LatestMarkers extends EmberLeaflet.MarkerCollectionLayer
	content: ~> @controller.latestLocations
	itemLayerClass: LatestMarker

class TargetMapView extends EmberLeaflet.MapView with CenterMap
	classNames: ['stacked']
	currentLocation: ~> @controller.session.currentLocation
	currentLeaf: ~> @controller.session.location
	childLayers: [TileLayer,MeCircle,MeMarker,LatestMarkers,TargetClusters]
	options:
		zoomControl:false
		attributionControl:false

	didCreateLayer: ->
		@_super()
		if @controller.length > 0
			@resetCenter()
		else
			@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)

	+observer controller.latestLocations
	onTargetContentChange: ->
		@resetCenter()

	+observer controller.targetHistoryLocations
	onLatestLocationsChange: ->
		@resetCenter()

	resetCenter: ->
		locationarray = [@currentLeaf]
		locationarray.push @controller.latestLocations.getEach 'location' if @controller.latestLocations
		locationarray.push @controller.targetHistoryLocations.getEach 'location' if @controller.targetHistoryLocations
		@centerMap(locationarray,@_layer)		

`export default TargetMapView`