IndexRoute = Ember.Route.extend(
	beforeModel: ->
		@_super()
		@controllerFor('application').toggleProperty('topNav')
		FB.getLoginStatus((response) =>
			@replaceWith('world') if response.status is 'connected'
		)
	deactivate: ->
		@controllerFor('application').toggleProperty('topNav')
		@_super
)

`export default IndexRoute`