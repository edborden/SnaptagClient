`import ServerTalk from 'appkit/mixins/server-talk'`

class InactivemapRoute extends Ember.Route with ServerTalk

	model:->
		@getServer("users", {inactive_map: true, lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude},"json"
		).then (response) ->
			return {
				users: response.users.map (item) ->
					location: L.latLng(item.locations[0].lat, item.locations[0].lon)
					## THIS IS NOT RIGHT, BUT WORKS
					popupContent: "Active Sleeper who has exposed " + item.exposed_count.toString() + " targets and has been hunting since " + moment(item.activated_at).fromNow() + "."
				zone: {location: L.latLng(response.zones[0].lat, response.zones[0].lon),radius: response.zones[0].range}
			}

`export default InactivemapRoute`