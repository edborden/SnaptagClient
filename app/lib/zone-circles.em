class ZoneCircle extends EmberLeaflet.CircleLayer
	options:
		fill: false
		weight: 2
		opacity: 1
		color: "black"

class ZoneCircles extends EmberLeaflet.CollectionLayer
	itemLayerClass: ZoneCircle
	contentBinding: 'controller.content.zones'

`export default ZoneCircles`