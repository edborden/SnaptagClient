HuntExposeRoute = Ember.Route.extend(
	actions:
		showexposescreen: ->
			@controllerFor('hunt.expose').toggleProperty('exposescreen')
)

`export default HuntExposeRoute`