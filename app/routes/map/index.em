`import ServerTalk from 'appkit/mixins/server-talk'`

class MapIndexRoute extends Ember.Route with ServerTalk
	model:->
		@getServer("users", {targets_with_locations: true}, "json"
		).then (response) =>
			controller = @controllerFor('map.index')
			numberOfTargets = response.users.length

			if numberOfTargets > 0
				controller.target1Name = response.users[0].name
				controller.target2Name = response.users[1].name if numberOfTargets > 1
				controller.target3Name = response.users[2].name if numberOfTargets is 3
				return {	
					zone: {
						location: L.latLng(response.zones[0].lat, response.zones[0].lon)
						radius: response.zones[0].range
					}
				}
			else
				return null

`export default MapIndexRoute`