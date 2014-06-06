meIcon = L.AwesomeMarkers.icon
    icon: 'user'
    markerColor: 'darkred'
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


	_createLayer: ->
		@_super()
		window.layerrr = @layer
#		addEventListener 'add', @layer.fireEvent("click")

class MeCircle extends EmberLeaflet.CircleLayer with MeLayerMixin

class LeafTileLayer extends EmberLeaflet.TileLayer
	tileUrl: 'http://{s}.tiles.mapbox.com/v3/edborden.i7622aec/{z}/{x}/{y}.png'

class MeMapView extends EmberLeaflet.MapView
	classNames: ['stacked']
	currentLocation: Ember.computed.alias "controller.session.currentLocation"
	childLayers: [LeafTileLayer,MeMarker,MeCircle]
	options:
		zoomControl:false
		attributionControl:false

	didInsertElement: ->
		@_super()
		console.log @childLayers[1]
		@childLayers[1].layer.fireEvent("click")


`export default MeMapView`