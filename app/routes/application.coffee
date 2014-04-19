ApplicationRoute = Ember.Route.extend(
	beforeModel: ->
		if localStorage['fbtoken']?
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
)

`export default ApplicationRoute`