`import ServerTalk from 'stalkers-client/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	beforeModel: -> @loc.setupLocation().then => @session.open()
	
	actions:
		logout: ->
			@session.close()
			@transitionTo 'index'

`export default ApplicationRoute`