MapView = Ember.View.extend(
	templateName: 'map'
	didInsertElement: ->
		map = L.map('map').setView([51.505, -0.09], 13)
		L.tileLayer('http://b.tile.cloudmade.com/{key}/{styleId}/256/{z}/{x}/{y}.png',
			styleId: 997
			key: "0b02ac66b87e4caf9a5890a13d2862e2"
			maxZoom: 18
		).addTo(map)
		marker = L.marker([51.5, -0.09]).addTo(map)
		circle = L.circle([51.508, -0.11], 500,
			color: 'red'
			fillColor: '#f03'
			fillOpacity: 0.5
		).addTo(map)
		polygon = L.polygon([[51.509, -0.08],[51.503, -0.06],[51.51, -0.047]]).addTo(map)
		marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup()
		circle.bindPopup("I am a circle.")
		polygon.bindPopup("I am a polygon.")
		popup = L.popup().setLatLng([51.5, -0.09]).setContent("I am a standalone popup.").openOn(map)
)

`export default MapView`