`import ServerTalk from 'appkit/mixins/server-talk'`

class InactivemapRoute extends Ember.Route with ServerTalk

	model:->
		@getServer("users", {inactive_map: true}, "json").then (response) ->
			return response.users.map (item) ->
				{location: L.latLng(item.locations[0].latitude, item.locations[0].longitude)}

`export default InactivemapRoute`