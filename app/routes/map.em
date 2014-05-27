`import ServerTalk from 'appkit/mixins/server-talk'`

class MapRoute extends Ember.Route with ServerTalk
	model:->
		@getServer("users", {targets_with_locations: true}, "json"
		).then (response) ->
			return {
				users: response.users.map (user) -> {
					locations: user.locations.map (loc) -> {
						location: L.latLng(loc.lat, loc.lon)
						popupContent: moment(loc.timestamp).fromNow()			
					}
				}
					## THIS IS NOT RIGHT, BUT WORKS			
				zone: {location: L.latLng(response.zones[0].lat, response.zones[0].lon),radius: response.zones[0].range}
			}

`export default MapRoute`