class ExecutiveService extends Ember.Service

	growler:Ember.inject.service()
	session:Ember.inject.service()
	realtime:Ember.inject.service()
	store:Ember.inject.service()
	loader:Ember.inject.service()

	action: (message,data) ->

		console.log "Executive received",message,data

		switch message

			when "Target Found"

				@me.suspects.removeObject data
				@me.targetsFoundCount = @me.targetsFoundCount + 1
				@loader.out()
				@router.transitionTo 'map'
				@growler.growl 8


			when "Stalker exposed"

				data.deleteRecord()
				@me.notifyPropertyChange 'suspects'
				@loader.out()
				@router.transitionTo 'map' 
				@growler.growl 9


			when "Exposed self"

				@me.exposedCount = @me.exposedCount + 1
				@loader.out()
				@goInactive()
				@growler.growl 10


			when "Found"

				@me.foundCount = @me.foundCount + 1
				@goInactive()
				@growler.growl 11


			when "Exposed"

				@me.exposedCount = @me.exposedCount + 1
				@goInactive()
				@growler.growl 12


			when "Target removed"

				@removeSuspect data.notifiedObjectId


			when "New target"

				user = @pushSuspect data
				@me.targets.pushObject user
				user.notifyPropertyChange 'isTarget'
				@realtime.watchTarget user


			when "New suspect"

				user = @pushSuspect data


			when "Suspect removed"

				@removeSuspect data


			when "Add user to activationqueue"

				user = @pushUser data
				@zone.users.pushObject user
				@activationqueue.usersCount = @activationqueue.usersCount + 1


			when "Remove user from activationqueue"

				user = @store.getById 'user', data
				@zone.users.removeObject user
				@activationqueue.usersCount = @activationqueue.usersCount - 1


			when "New target location"
			
				@store.pushPayload data
				location = @store.getById 'location', data.location.id
				target = location.user
				target.locations.pushObject location
				target.notifyPropertyChange 'latestLocation'
				@map.notifyPropertyChange 'latestLocations'


			when "Added to activationqueue"

				@loader.in()
				@store.find('activationqueue',data.notifiedObjectId).then (activationqueue) =>
					@session.me.activationqueue = activationqueue
					@session.me.status = "queue"
					@loader.out()
					@router.transitionTo 'inactivemap'
				@growler.growl 6


			when "You have entered the game"

				@loader.in() 
				@session.refresh().then => 
					@session.me.status = 'active'
					@loader.out()
					@router.transitionTo 'map'
				@growler.growl 5

	## HELPERS

	me: ~> @session.me
	activationqueue: ~> @me.activationqueue
	zone: ~> @activationqueue.zone if @activationqueue?

	goInactive: ->
		@me.status = 'inactive'
		@me.suspects.clear()
		@me.targets.clear()		
		@router.transitionTo 'inactivemap'

	pushUser: (data) ->
		@store.pushPayload data
		user = @store.getById 'user', data.user.id		
		return user

	pushSuspect: (data) ->
		user = @pushUser data
		@me.suspects.pushObject user
		@me.notifyPropertyChange 'suspects'
		return user

	removeSuspect: (userId) ->
		user = @store.getById 'user', userId
		@me.suspects.removeObject user
		@me.targets.removeObject user
		@me.notifyPropertyChange 'suspects'
		user.deleteRecord()

`export default ExecutiveService`