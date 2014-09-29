`import TileLayer from 'appkit/lib/tile-layer'`
`import MeCircle from 'appkit/lib/me-circle'`
`import MeMarker from 'appkit/lib/me-marker'`
`import ThemClusters from 'appkit/lib/them-clusters'`

class IntroMapView extends EmberLeaflet.MapView
	classNames: ['stacked']
	currentLocation: ~> @controller.session.currentLocation
	childLayers: [TileLayer,MeCircle,MeMarker]
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
		@objectAt(2).openPopup()
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