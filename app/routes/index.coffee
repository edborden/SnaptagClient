class IndexRoute extends Ember.Route
	beforeModel: ->
		@_super()
		if localStorage['fbtoken']?
			@replaceWith('map')
		else
			@controllerFor('application').toggleProperty('topNav')

	deactivate: ->
		@controllerFor('application').toggleProperty('topNav')
		@_super

`export default IndexRoute`