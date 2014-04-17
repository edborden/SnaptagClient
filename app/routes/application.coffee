ApplicationRoute = Ember.Route.extend(
	beforeModel: ->
		navigator.geolocation.getCurrentPosition( (location) ->
			console.log('Location from Phonegap')
			enableHighAccuracy: true
		)
		navigator.geolocation.watchPosition( (position) ->
			console.log("app route watch" + position)
			enableHighAccuracy: true
		)
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