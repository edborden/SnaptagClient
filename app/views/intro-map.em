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
		Ember.$ ->
			Ember.$(".typed").typed
				strings: ["You ^400 are ^500 being ^400 watched."]
				typeSpeed: 50
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