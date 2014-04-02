HuntIndexRoute = Ember.Route.extend(
	model: ->
		this.store.find('user',{ web: true })
)

`export default HuntIndexRoute`