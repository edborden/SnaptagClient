`import ServerTalk from 'appkit/mixins/server-talk'`

class IndexRoute extends Ember.Route with ServerTalk
	beforeModel: ->
		if @session.active
			@replaceWith 'map'
		else if @session.loggedIn
			@replaceWith 'inactivemap' 
		@_super()

	model:->
		@getServer("users", {intro_map: true}, "json").then (response) ->
			return response.users.map (item) ->
				{location: L.latLng(item.locations[0].latitude, item.locations[0].longitude)}

`export default IndexRoute`