# hack to allow more than one popup open on the screen
class L.Map extends L.Map
	openPopup: (popup) ->
		@_popup = popup
		return @addLayer(popup).fire 'popupopen', {popup: @_popup}

`import TileLayer from 'appkit/lib/tile-layer'`
`import MeCircle from 'appkit/lib/me-circle'`
`import MeMarker from 'appkit/lib/me-marker'`
`import ZoneCircles from 'appkit/lib/zone-circles'`
`import TargetClusters from 'appkit/lib/target-clusters'`

latestIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'darkblue'
	prefix: 'fa'

class LatestMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: latestIcon}
	content: ~> return @controller.targetContent.latestLocation
	popupContent: ~> return @content.popupContent
#	_createLayer: ->
#		@_super()
#		addEventListener 'add', @openPopup()

#~>
#		return @content.users.map (user) -> user.latestLocation unless activeTarget?

class Latest1Marker extends LatestMarker
#	content: ~> if @controller.latestLocations[0]? then return @controller.latestLocations[0] else return null
	_createLayer: ->
		@_super()
#		addEventListener 'add', @openPopup()
class Latest2Marker extends LatestMarker
#	content: ~> return @controller.latestLocations[1]
	_createLayer: ->
		@_super()
#		addEventListener 'add', @openPopup()
class Latest3Marker extends LatestMarker
#	content: ~> return @controller.latestLocations[2]
	_createLayer: ->
		@_super()
#		addEventListener 'add', @openPopup()

class TargetMapView extends EmberLeaflet.MapView
	classNames: ['stacked']
	currentLocation: Ember.computed.alias "controller.session.currentLocation"
	childLayers: [TileLayer,MeCircle,MeMarker,ZoneCircles,TargetClusters,LatestMarker]
	options:
		zoomControl:false
		attributionControl:false

	didCreateLayer: ->
		@_super()
		$ ->
			$(".typed").typed
				strings: ["You ^400 are ^500 being ^400 watched."]
				typeSpeed: 50
		@_layer.setView([@currentLocation.coords.latitude, @currentLocation.coords.longitude], 14)
		#@childLayers[2].openPopup()
		#markerarray = @childLayers[4].childLayers[0].childLayers.map (marker) -> marker.content.location
		#bounds = L.latLngBounds(markerarray)
		#@_layer.fitBounds(bounds)

`export default TargetMapView`