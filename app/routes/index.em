class IndexRoute extends Ember.Route
	beforeModel: ->
		if @session.active
			@replaceWith 'map'
		else if @session.loggedIn
			@replaceWith 'inactivemap' 
		@_super()

	model:->
		@store.find 'user',{inactive_map: true, lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude}

`export default IndexRoute`