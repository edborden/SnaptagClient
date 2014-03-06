IndexRoute = Ember.Route.extend(
	beforeModel: ->
		this.transitionTo('world')
)

`export default IndexRoute`
