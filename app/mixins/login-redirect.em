LoginRedirect = Ember.Mixin.create

	beforeModel: ->
		if @session.active
			@replaceWith 'map'
		else if @session.loggedIn
			@replaceWith 'inactivemap' 

`export default LoginRedirect`