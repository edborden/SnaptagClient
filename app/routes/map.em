class MapRoute extends Ember.Route

	model:->
		@session.me.targets

`export default MapRoute`