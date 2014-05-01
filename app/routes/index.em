class IndexRoute extends Ember.Route
	beforeModel: ->
		@_super()
		@replaceWith('map') if @controllerFor('application').loggedIn

`export default IndexRoute`