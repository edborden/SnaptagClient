IndexRoute = Ember.Route.extend(
	beforeModel: ->
		this.replaceWith('world')
)

`export default IndexRoute`
