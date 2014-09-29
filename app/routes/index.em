class IndexRoute extends Ember.Route
	beforeModel: ->
		if @session.me? && @session.me.status is 'active'
			@replaceWith 'map'
		else if @session.loggedIn
			@replaceWith 'inactivemap' 

	model:->
		@store.find 'zone',{lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude}

`export default IndexRoute`