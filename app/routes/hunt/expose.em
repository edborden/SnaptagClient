class HuntExposeRoute extends Ember.Route
	actions:
		showexposescreen: ->
			@controllerFor('hunt.expose').toggleProperty('exposescreen')

`export default HuntExposeRoute`