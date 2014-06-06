`import MeLayer from 'appkit/mixins/me-layer'`

meIcon = L.AwesomeMarkers.icon
    icon: 'user'
    markerColor: 'darkred'
    prefix: 'fa'

class MeMarker extends EmberLeaflet.MarkerLayer with MeLayer, EmberLeaflet.PopupMixin
	options: {icon: meIcon}
	popupContent: "You."
	popupOptions: {offset: L.point(0, -36),closeButton:false}

`export default MeMarker`