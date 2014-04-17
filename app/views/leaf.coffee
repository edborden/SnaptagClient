MarkerCollectionLayer = EmberLeaflet.MarkerCollectionLayer.extend(
	contentBinding: 'controller'
)

LeafTileLayer = EmberLeaflet.TileLayer.extend(
	tileUrl: 'http://{s}.tile.cloudmade.com' + '/{key}/{styleId}/256/' + '{z}/{x}/{y}.png'
	options:
		key: "0b02ac66b87e4caf9a5890a13d2862e2"
		styleId: 999
)

LeafView = EmberLeaflet.MapView.extend(
	classNames: ['stacked']
	didCreateLayer: ->
		@_super()
		navigator.geolocation.getCurrentPosition( (position) =>
			console.log "didCreateLayerget"
			@_layer.setView([position.coords.latitude, position.coords.longitude], 14)
			enableHighAccuracy: true
		)
		watchid = navigator.geolocation.watchPosition( (position) =>
			console.log "didCreateLayer"
			@_layer.setView([position.coords.latitude, position.coords.longitude], 14)
			enableHighAccuracy: true
		)
		@watchid = watchid

	childLayers: [LeafTileLayer,MarkerCollectionLayer]
	options:
		zoomControl:false
	watchid: null
	destroy: ->
		navigator.geolocation.clearWatch(@watchid)
		@_super

)

`export default LeafView`