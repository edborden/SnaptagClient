MeIndexRoute = Ember.Route.extend(
	model: ->
		this.store.find('user','me')
)

`export default MeIndexRoute`