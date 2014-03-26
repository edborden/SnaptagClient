IndexRoute = Ember.Route.extend(
	beforeModel: ->
		this._super()
		_this = this
		FB.getLoginStatus((response) ->
			_this.replaceWith('world') if response.status is 'connected'
	)
)

`export default IndexRoute`