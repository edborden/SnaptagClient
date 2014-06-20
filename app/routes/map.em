class MapRoute extends Ember.Route

	model:->
		@store.find 'user',{targets_with_locations: true}

`export default MapRoute`