`import ServerTalk from 'appkit/mixins/server-talk'`

class MapOneRoute extends Ember.Route with ServerTalk
	model:->
		@getServer("users", {targets_with_locations: true}, "json"
		).then (response) =>
			controller = @controllerFor('map.one')
			numberOfTargets = response.users.length
			locations_array = response.users[0].locations.map (loc) -> {
							location: L.latLng(loc.lat, loc.lon)
							popupContent: "Latest location, " + moment(loc.timestamp).fromNow()			
			}
			latestLocation = locations_array.pop()

			if numberOfTargets > 0
				controller.target1Name = response.users[0].name
				controller.target2Name = response.users[1].name if numberOfTargets > 1
				controller.target3Name = response.users[2].name if numberOfTargets is 3
				return {
					user: {
						locations: locations_array	
						latestLocation: latestLocation		
					}
						## THIS IS NOT RIGHT, BUT WORKS			
					zone: {
						location: L.latLng(response.zones[0].lat, response.zones[0].lon)
						radius: response.zones[0].range
					}
				}
			else
				return null

`export default MapOneRoute`