meIcon = L.AwesomeMarkers.icon
    icon: 'user'
    markerColor: 'blue'
    prefix: 'fa'

class MeMarker extends EmberLeaflet.MarkerLayer
	options: {icon: meIcon}

class MeMarkerLayer extends EmberLeaflet.MarkerCollectionLayer
	init: ->
		@_super()
		@content = [{location: L.latLng(@currentLocation.coords.latitude, @currentLocation.coords.longitude)}] if @currentLocation?

	currentLocation: Ember.computed.alias "controller.controllers.application.currentLocation"
	content: []
	itemLayerClass: MeMarker

	+observer controller.controllers.application.currentLocation
	onLocationChange: ->
		@content = [{location: L.latLng(@currentLocation.coords.latitude, @currentLocation.coords.longitude)}]

class MarkerCollectionLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller'
	itemLayerClass: MeMarker
	
class LeafTileLayer extends EmberLeaflet.TileLayer
	tileUrl: 'http://{s}.tile.cloudmade.com' + '/{key}/{styleId}/256/' + '{z}/{x}/{y}.png'
	options:
		key: "0b02ac66b87e4caf9a5890a13d2862e2"
		styleId: 999

class LeafView extends EmberLeaflet.MapView
	classNames: ['stacked']

	init: ->
		@_super()
		@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14) if @currentLocation?

	currentLocation: Ember.computed.alias "controller.controllers.application.currentLocation"

	+observer controller.controllers.application.currentLocation
	onLocationChange: ->
		@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)

	childLayers: [LeafTileLayer,MarkerCollectionLayer,MeMarkerLayer]
	options:
		zoomControl:false

`export default LeafView`