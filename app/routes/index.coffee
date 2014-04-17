IndexRoute = Ember.Route.extend(
	beforeModel: ->
		if localStorage['fbtoken']?
			@replaceWith('world')
		else
			@controllerFor('application').toggleProperty('topNav')
			@_super()
	deactivate: ->
		@controllerFor('application').toggleProperty('topNav')
		@_super
)

`export default IndexRoute`