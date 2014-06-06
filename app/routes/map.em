`import ServerTalk from 'appkit/mixins/server-talk'`

class MapRoute extends Ember.Route with ServerTalk
	model:->
		@getServer("users", {targets_with_locations: true}, "json"
		).then (response) ->
			if response.users?
				users = response.users.map (user) -> {
					name: user.name
					locations: user.locations.map (loc) -> {
						location: L.latLng(loc.lat, loc.lon)
						popupContent: moment.unix(loc.timestamp).fromNow()								
					}
				}

				users.forEach (user) ->
					user['latestLocation'] = user.locations.pop()

				users.forEach (user) ->
					user.latestLocation.popupContent = "Your target, " + user.name + ", was last seen here " + user.latestLocation.popupContent


				return {
					users
						## THIS IS NOT RIGHT, BUT WORKS			
					zone: {
						location: L.latLng(response.zones[0].lat, response.zones[0].lon)
						radius: response.zones[0].range
					}
				}
			else
				return null
	setupController: (controller,model) ->
		@_super(controller,model)
		controller.latestLocationsArray = model.users.map (user) -> user.latestLocation

`export default MapRoute`