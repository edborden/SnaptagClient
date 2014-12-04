RealTime = new Ember.Mixin
	
	+observer me.status, session.model
	setPusher: ->
		Ember.run.next @, =>
			if @session.model?
				@pusher.disconnect() if @pusher? and @session.inactive
				@pusher = new Pusher '0750760773b8ed5ae1dc' unless @pusher?
				if @session.queue
					console.log 'queue subscriptions'
					return # real-time queue sync here
				if @session.active
					channel = @pusher.subscribe @me.id
					channel.bind 'notification', (data) =>
						notification = @pushNotification data
						if notification.subject is "Found"
							@me.foundCount = @me.foundCount + 1
							@goInactive()
							Bootstrap.GNM.push 'Found', 'You were found.', 'warning'
						if notification.subject is "Exposed"
							@me.exposedCount = @me.exposedCount + 1
							@goInactive()
							Bootstrap.GNM.push 'Exposed', 'You were exposed.', 'warning'
						if notification.subject is "Target removed"
							@removeSuspect notification.notifiedObjectId						
					channel.bind 'new_target', (data) =>
						user = @pushSuspect data
						@me.targets.pushObject user
						user.notifyPropertyChange 'isTarget'
					channel.bind 'new_suspect', @pushSuspect, @
					channel.bind 'remove_suspect', @removeSuspect, @
					@me.suspects.forEach (suspect) =>
						channel = @pusher.subscribe suspect.id
						channel.bind 'remove', @removeSuspect, @
						if suspect.isTarget
							channel.bind 'location', (data) =>
								@store.pushPayload data
								location = @store.getById 'location', data.location.id
								suspect.locations.pushObject location
								suspect.notifyPropertyChange 'latestLocation'
								@controllerFor('map').notifyPropertyChange 'latestLocations'
			else
				@pusher.disconnect() if @pusher?

	pushSuspect: (data) ->
		@store.pushPayload data
		user = @store.getById 'user', data.user.id
		@me.suspects.pushObject user
		@me.notifyPropertyChange 'suspects'
		return user

	removeSuspect: (userId) ->
		user = @store.getById 'user', userId
		@me.suspects.removeObject user
		@me.targets.removeObject user
		@me.notifyPropertyChange 'suspects'

	pushNotification: (response) ->
		@store.pushPayload response
		notification = @store.getById 'notification',response.notification.id
		@me.notifications.unshiftObject notification
		return notification		

`export default RealTime`