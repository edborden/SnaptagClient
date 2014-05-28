class ZoneCircle extends EmberLeaflet.CircleLayer
	contentBinding: 'controller.content.zone'
	options:
		fill: false
		weight: 2
		opacity: 1
		color: "black"

meIcon = L.AwesomeMarkers.icon
    icon: 'user'
    markerColor: 'cadetblue'
    prefix: 'fa'

MeLayerMixin = Ember.Mixin.create
	init: ->
		@_super()
		@content = {location: L.latLng(@currentLocation.coords.latitude, @currentLocation.coords.longitude),radius: @currentLocation.coords.accuracy}

	currentLocation: Ember.computed.alias "controller.session.currentLocation"
	content: {}

	+observer currentLocation
	onLocationChange: ->
		@content = {location: L.latLng(@currentLocation.coords.latitude, @currentLocation.coords.longitude),radius: @currentLocation.coords.accuracy}

class MeMarker extends EmberLeaflet.MarkerLayer with MeLayerMixin, EmberLeaflet.PopupMixin
	options: {icon: meIcon}
	popupContent: "You."
	popupOptions: {offset: L.point(0, -36),closeButton:false}

class MeCircle extends EmberLeaflet.CircleLayer with MeLayerMixin

class LeafTileLayer extends EmberLeaflet.TileLayer
	tileUrl: 'http://{s}.tiles.mapbox.com/v3/edborden.i7622aec/{z}/{x}/{y}.png'

class MeMapView extends EmberLeaflet.MapView
	classNames: ['stacked']
	currentLocation: Ember.computed.alias "controller.session.currentLocation"
	childLayers: [LeafTileLayer,MeMarker,MeCircle,ZoneCircle]
	options:
		zoomControl:false
		attributionControl:false

	didInsertElement: ->
		@_super()
		@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)

`export default MeMapView`