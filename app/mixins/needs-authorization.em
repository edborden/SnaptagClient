NeedsAuthorization = Ember.Mixin.create

	loginRoute: 'index'

	beforeModel: ->
		@replaceWith @loginRoute unless @session.loggedIn
			
`export default NeedsAuthorization`