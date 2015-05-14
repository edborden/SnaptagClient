class ApplicationRoute extends Ember.Route

	beforeModel: -> @session.open()
	
	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'

`export default ApplicationRoute`