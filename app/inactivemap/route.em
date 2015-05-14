class InactivemapRoute extends Ember.Route

	model:->
		@store.find 'zone',@geolocation.object

`export default InactivemapRoute`