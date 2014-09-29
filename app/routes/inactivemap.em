class InactivemapRoute extends Ember.Route
	
	beforeModel: ->
		if @session.me? && @session.me.status is 'active'
			@replaceWith 'map'
	model:->
		@store.find 'zone',{lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude}

`export default InactivemapRoute`