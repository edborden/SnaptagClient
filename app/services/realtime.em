class RealtimeService extends Ember.Service
	store:Ember.inject.service()
	session:Ember.inject.service()
	growler:Ember.inject.service()
	me: ~> @session.me
	pusher: null
	status: null
	# Set in intializer to MapController
	map: null

	init: ->
		@_super()
		@statusChanged()

	+observer session.me.status, session.loggedIn
	statusChanged: ->
		@disconnect() if @pusher?
		if @session.queue
			@setPusher()
			@setPusherQueue() 
		if @session.active
			@setPusher()
			@setPusherActive() 
				
	disconnect: -> @pusher.disconnect()

	setPusher: -> @pusher = new Pusher '0750760773b8ed5ae1dc'

	setPusherActive: ->
		@status = 'active'
		channel = @pusher.subscribe "user#{@me.id}"
		channel.bind 'notification', (data) =>
			console.log 'notification push',data
			notification = @pushNotification data
			if notification.subject is "Found"
				@me.foundCount = @me.foundCount + 1
				@goInactive()
				@growler.growl 11
			if notification.subject is "Exposed"
				@me.exposedCount = @me.exposedCount + 1
				@goInactive()
				@growler.growl 12
			if notification.subject is "Target removed"
				@removeSuspect notification.notifiedObjectId
		channel.bind 'new_target', (data) =>
			user = @pushSuspect data
			@me.targets.pushObject user
			user.notifyPropertyChange 'isTarget'
			@watchSuspect user
		channel.bind 'new_suspect', (data) =>
			user = @pushSuspect data
			@watchSuspect user
		channel.bind 'remove_suspect', @removeSuspect, @
		@me.suspects.forEach (suspect) =>
			@watchSuspect suspect		

	setPusherQueue: ->
		@status = 'queue'
		activationqueue = @me.activationqueue
		zone = activationqueue.zone
		channel = @pusher.subscribe "activationqueue"+activationqueue.id
		channel.bind 'add_user', (data) =>
			console.log "before " + activationqueue.usersCount
			if activationqueue.usersCount is 11
				@transitionTo('loading').then( => @session.open() ).then => @transitionTo 'map'
			else
				user = @pushUser data
				zone.users.pushObject user
				activationqueue.usersCount = activationqueue.usersCount + 1
				console.log "after " + activationqueue.usersCount
		channel.bind 'remove_user', (data) =>
			user = @store.getById 'user', data.user.id
			zone.users.removeObject user
			activationqueue.usersCount = activationqueue.usersCount - 1		

	watchSuspect: (suspect) ->
		channel = @pusher.subscribe "user"+suspect.id
		channel.bind 'remove', @removeSuspect, @
		if suspect.isTarget
			channel.bind 'location', (data) =>
				@store.pushPayload data
				#location = @store.getById 'location', data.location.id
				#suspect.locations.pushObject location
				suspect.notifyPropertyChange 'latestLocation'
				@map.notifyPropertyChange 'latestLocations'

	pushUser: (data) ->
		@store.pushPayload data
		user = @store.getById 'user', data.user.id		
		return user

	pushSuspect: (data) ->
		user = @pushUser data
		@me.suspects.pushObject user
		#@me.notifyPropertyChange 'suspects'
		return user

	removeSuspect: (userId) ->
		user = @store.getById 'user', userId
		#@me.suspects.removeObject user
		#@me.targets.removeObject user
		#@me.notifyPropertyChange 'suspects'
		user.deleteRecord()

	pushNotification: (response) ->
		@store.pushPayload response
		@session.me.notifyPropertyChange 'unreadNotifications'
		notification = @store.getById 'notification',response.notification.id
		#@me.notifications.unshiftObject notification
		return notification		

`export default RealtimeService`