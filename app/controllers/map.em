class MapController extends Ember.ArrayController
	needs: ['application']

	content: [
		{location: L.latLng(40.714, -74.000)},
		{location: L.latLng(40.714, -73.989)},
		{location: L.latLng(40.721, -73.991)}
	]

`export default MapController`