`import MeMapView from 'appkit/views/me-map'`

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

themIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'green'
	prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContentBinding: 'content.popupContent'

class TargetMarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	content: ~> return @controller.targetContent.locations
	itemLayerClass: ThemMarker

class ClusterLayer extends EmberLeaflet.ContainerLayer
	childLayers: [TargetMarkersLayer]
	_newLayer: ->
		new L.MarkerClusterGroup({maxClusterRadius:60})

class TargetMapView extends MeMapView
	init: ->
		@_super()
		@childLayers.push ClusterLayer,LatestMarker,Latest1Marker,Latest2Marker,Latest3Marker

`export default TargetMapView`