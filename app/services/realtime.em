class RealtimeService extends Ember.Service
	store:Ember.inject.service()
	session:Ember.inject.service()
	growler:Ember.inject.service()
	notificator:Ember.inject.service()
	executive:Ember.inject.service()

	me: ~> @session.me
	pusher: null
	# Set in intializer to MapController
	map: null

	init: ->
		@_super()
		@statusChanged()

	+observer session.me.status, session.loggedIn
	statusChanged: ->
		console.log 'statusChanged'
		@disconnect() if @pusher?
		if @session.loggedIn
			@setPusher()
			@subscribeToNotifications()
			if @session.queue
				@setPusherQueue() 
			if @session.active
				@setPusherActive() 
			if @session.inactive
				@setPusherInactive()
				
	disconnect: -> @pusher.disconnect()

	subscribeToNotifications: ->
		channel = @pusher.subscribe "user#{@me.id}"

		channel.bind 'notification', (data) =>
			console.log 'notification push',data
			message = @notificator.handle data
			@executive.action message,data	

	setPusher: -> @pusher = new Pusher '0750760773b8ed5ae1dc'

	setPusherInactive: ->
		console.log 'setPusherInactive'

	setPusherActive: ->
		console.log 'setPusherActive'
		channel = @pusher.subscribe "user#{@me.id}"

		messages = ["New target","New suspect","Suspect removed"]
		@bindMessagesToChannel messages,channel

		@me.targets.forEach (target) => @watchTarget target		

	setPusherQueue: ->
		console.log 'setPusherQueue'

		channel = @pusher.subscribe "user#{@me.id}"
		messages = ["You have entered the game"]
		@bindMessagesToChannel messages,channel

		channel = @pusher.subscribe "activationqueue"+@me.activationqueue.id
		messages = ["Add user to activationqueue","Remove user from activationqueue"]
		@bindMessagesToChannel messages,channel

	watchTarget: (target) ->
		channel = @pusher.subscribe "user"+target.id
		messages = ['New target location']
		@bindMessagesToChannel messages,channel

	bindMessagesToChannel: (messages,channel) ->
		messages.forEach (message) =>
			channel.bind message, (data) => @executive.action message,data

`export default RealtimeService`