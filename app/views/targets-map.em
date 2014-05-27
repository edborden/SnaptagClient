`import MeMapView from 'appkit/views/me-map'`

class ZoneCircle extends EmberLeaflet.CircleLayer
	contentBinding: 'controller.content.zone'
	options:
		fill: false
		weight: 2
		opacity: 1
		color: "black"

themIcon = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'darkred'
	prefix: 'fa'

class ThemMarker extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon}
	popupContentBinding: 'content.popupContent'

class Target1MarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller.content.target1.locations'
	itemLayerClass: ThemMarker

themIcon2 = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'blue'
	prefix: 'fa'

class ThemMarker2 extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon2}
	popupContentBinding: 'content.popupContent'

class Target2MarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller.content.target2.locations'
	itemLayerClass: ThemMarker2

themIcon3 = L.AwesomeMarkers.icon
	icon: 'crosshairs'
	markerColor: 'darkgreen'
	prefix: 'fa'

class ThemMarker3 extends EmberLeaflet.MarkerLayer with EmberLeaflet.PopupMixin
	options: {icon: themIcon3}
	popupContentBinding: 'content.popupContent'

class Target3MarkersLayer extends EmberLeaflet.MarkerCollectionLayer
	contentBinding: 'controller.content.users[0].locations'
	itemLayerClass: ThemMarker3
	didCreateLayer: ->
		@_super()
		console.log @controller.content.users[0].locations
#		console.log @parentLayer
#		L.easyButton 'fa-crosshairs', null, @parentLayer.parentLayer

class ClusterLayer extends EmberLeaflet.ContainerLayer
	childLayers: [Target1MarkersLayer,Target2MarkersLayer,Target3MarkersLayer]
	_newLayer: ->
		new L.MarkerClusterGroup({maxClusterRadius:60})

	didCreateLayer: ->
		@_super()
#		console.log @parentLayer
#		console.log @_childLayers
#		@_layer.removeLayer @_childLayers[0]

#		console.log @_layer
#		L.easyButton 'fa-crosshairs', null, @_layer

class TargetsMapView extends MeMapView
	init: ->
		@_super()
		@childLayers.push ClusterLayer,ZoneCircle

	clusterLayerObj: ~>
		@_childLayers[3]

	zoneLayerObj: ~>
		@_childLayers[4]

	target1Obj: ~>
		@_childLayers[3]._childLayers[0]

	didCreateLayer: ->
		@_super()
#		console.log @parentLayer
#		console.log @_layer
#		console.log @_childLayers[3]
#		console.log @clusterLayerObj.layer
		L.easyButton 'fa-crosshairs', null, @_layer, =>	
			@_childLayers.push ClusterLayer,ZoneCircle
		L.easyButton 'fa-crosshairs', null, @_layer, =>	
			@_childLayers.push ClusterLayer,ZoneCircle
		L.easyButton 'fa-crosshairs', null, @_layer, =>	
			@_childLayers.push ClusterLayer,ZoneCircle


`export default TargetsMapView`