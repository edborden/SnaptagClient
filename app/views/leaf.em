meIcon = L.AwesomeMarkers.icon
    icon: 'user'
    markerColor: 'blue'
    prefix: 'fa'

MeLayerMixin = Ember.Mixin.create
	init: ->
		@_super()
		@content = {location: L.latLng(@currentLocation.coords.latitude, @currentLocation.coords.longitude),radius: @currentLocation.coords.accuracy} if @currentLocation?

	currentLocation: Ember.computed.alias "controller.controllers.application.currentLocation"
	content: []

	+observer controller.controllers.application.currentLocation
	onLocationChange: ->
		@content = {location: L.latLng(@currentLocation.coords.latitude, @currentLocation.coords.longitude),radius: @currentLocation.coords.accuracy}

class MeMarker extends EmberLeaflet.MarkerLayer with MeLayerMixin
	options: {icon: meIcon}

class MarkerCollectionLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller'

class MeCircle extends EmberLeaflet.CircleLayer with MeLayerMixin
	
class LeafTileLayer extends EmberLeaflet.TileLayer
	tileUrl: 'http://{s}.tile.cloudmade.com' + '/{key}/{styleId}/256/' + '{z}/{x}/{y}.png'
	options:
		key: "0b02ac66b87e4caf9a5890a13d2862e2"
		styleId: 999

class LeafView extends EmberLeaflet.MapView
	classNames: ['stacked']

	currentLocation: Ember.computed.alias "controller.controllers.application.currentLocation"

	+observer controller.controllers.application.currentLocation
	onLocationChange: ->
		@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)

	childLayers: [LeafTileLayer,MarkerCollectionLayer,MeMarker,MeCircle]
	options:
		zoomControl:false
		attributionControl:false

`export default LeafView`