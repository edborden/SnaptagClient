`import TileLayer from 'stalkers-client/views/map-layers/tile-layer'`
`import MeLayer from 'stalkers-client/views/map-layers/me-layer'`
`import ThemClusters from 'stalkers-client/views/map-layers/them-clusters'`

class IntroMapView extends EmberLeaflet.MapView
	geolocation: Ember.inject.service()
	childLayers: [TileLayer,MeLayer]
	options:
		zoomControl:false
		attributionControl:false

	didCreateLayer: ->
		@_super()
		@createZoneClusters()
		@_layer.setView(@geolocation.array, 14)
		if @markerArray.length > 0
			bounds = L.latLngBounds @markerArray
			@_layer.fitBounds bounds

	createZoneClusters: ->
		@controller.forEach (zone) =>
			layer = @createChildLayer ThemClusters, content: zone
			@addChildLayer layer

	markerArray: ~>
		markerArray = []
		@controller.forEach (zone) ->
			zone.users.forEach (user) ->
				markerArray.push user.location
		return markerArray		

`export default IntroMapView`