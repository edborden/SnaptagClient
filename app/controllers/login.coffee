LoginController = Ember.ObjectController.extend(
	
	actions:
		login: ->
			_this = this
			FB.login( (response) ->
				if response.authResponse
					_this.transitionToRoute('world')

			)

	# login = ->
	# run FB login
	# reset nav?
)

`export default LoginController`