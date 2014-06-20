class InactivemapRoute extends Ember.Route

	model:->
		@store.find 'user',{inactive_map: true, lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude}

`export default InactivemapRoute`