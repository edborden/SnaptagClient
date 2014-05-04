class ApplicationRoute extends Ember.Route
	beforeModel: ->
		if @controllerFor('application').loggedIn is false then @replaceWith('index')
		@_super()

	actions:
		updatelocation: ->
			console.log "UPDATELOCATION EVENT"
		back: ->
			window.history.go(-1)

`export default ApplicationRoute`