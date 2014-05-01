class ApplicationRoute extends Ember.Route
	beforeModel: ->
		if @controllerFor('application').loggedIn
			$.ajaxSetup(
				data: {"token": localStorage['fbtoken']}
			)
			pusher = new Pusher('0750760773b8ed5ae1dc')
			channel = pusher.subscribe(localStorage['fbtoken'])
			channel.bind('updatelocation', =>
				@send('updatelocation')
			)
			@_super()
		else
			@replaceWith('index')

	actions:
		updatelocation: ->
			console.log "UPDATELOCATION EVENT"
		back: ->
			window.history.go(-1)

`export default ApplicationRoute`