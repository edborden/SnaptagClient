`import ServerTalk from 'appkit/mixins/server-talk'`

class IndexRoute extends Ember.Route with ServerTalk
	beforeModel: ->
		if @session.active
			@replaceWith 'map'
		else if @session.loggedIn
			@replaceWith 'inactivemap' 
		@_super()

	model:->
		@getServer("users", {inactive_map: true, lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude},"json"
		).then (response) ->
			return {
				users: response.users.map (user) -> {
					location: L.latLng(user.lat, user.lon)
					## THIS IS NOT RIGHT, BUT WORKS
					popupContent: "Active Sleeper who has exposed " + user.exposed_count.toString() + " targets and has been hunting since " + moment(user.activated_at).fromNow() + "."
				}
				zones: response.zones.map (zone) -> {
					location: L.latLng(zone.lat, zone.lon)
					radius: zone.range
				}
			}

`export default IndexRoute`