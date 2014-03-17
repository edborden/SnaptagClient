Protected = Ember.Mixin.create(
	beforeModel: ->
		_this = this
		FB.getLoginStatus( (response) ->
			if response.status isnt 'connected'
				_this.replaceWith('login')
		)
)
`export default Protected`