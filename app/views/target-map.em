`import TileLayer from 'stalkers-client/views/map-layers/tile-layer'`
`import MeLayer from 'stalkers-client/views/map-layers/me-layer'`
#`import ZoneCircles from 'appkit/views/map-layers/zone-circles'`
`import TargetClusters from 'stalkers-client/views/map-layers/target-clusters'`
`import CenterMap from 'stalkers-client/mixins/center-map'`

latestIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'darkred'
	prefix: 'fa'

class LatestMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: latestIcon}
	popupContent: ~> @content.popupContent

class LatestMarkers extends EmberLeaflet.MarkerCollectionLayer
	content: ~> @controller.latestLocations
	itemLayerClass: LatestMarker

class TargetMapView extends EmberLeaflet.MapView with CenterMap
	geolocation:Ember.inject.service()
	childLayers: [TileLayer,MeLayer,LatestMarkers,TargetClusters]
	options:
		zoomControl:false
		attributionControl:false

	didCreateLayer: ->
		@_super()
		if @controller.length > 0
			@resetCenter()
		else
			@_layer.setView(@geolocation.array, 14)

	+observer controller.latestLocations
	onTargetContentChange: ->
		@resetCenter()

	+observer controller.targetHistoryLocations
	onLatestLocationsChange: ->
		@resetCenter()

	resetCenter: ->
		locationarray = [@geolocation.location]
		locationarray.push @controller.latestLocations.getEach 'location' if @controller.latestLocations
		locationarray.push @controller.targetHistoryLocations.getEach 'location' if @controller.targetHistoryLocations
		@centerMap(locationarray,@_layer)		

`export default TargetMapView`