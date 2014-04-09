IndexRoute = Ember.Route.extend(
	beforeModel: ->
		this.controllerFor('application').toggleProperty('topNav')
		_this = this
		FB.getLoginStatus((response) ->
			_this.replaceWith('world') if response.status is 'connected'
	)
)

`export default IndexRoute`