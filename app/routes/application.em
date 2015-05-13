class ApplicationRoute extends Ember.Route

	beforeModel: -> @loc.setupLocation().then => @session.open()
	
	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'

`export default ApplicationRoute`