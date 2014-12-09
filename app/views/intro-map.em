`import TileLayer from 'appkit/lib/tile-layer'`
`import MeLayer from 'appkit/lib/me-layer'`
`import ThemClusters from 'appkit/lib/them-clusters'`

class IntroMapView extends EmberLeaflet.MapView
	currentLocation: ~> @controller.session.currentLocation
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
		@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)
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