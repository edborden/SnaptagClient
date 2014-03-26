IndexController = Ember.ObjectController.extend(
	
	actions:
		login: ->
			_this = this
			FB.login( (response) ->
				if response.authResponse
					$.get("http://www.gridweb.com/users/login.json",
						facebookid: response.authResponse.userID
						token: response.authResponse.accessToken
						-> _this.transitionToRoute('world')
					)
			)
)

`export default IndexController`