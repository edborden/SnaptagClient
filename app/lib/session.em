class Session extends Ember.Object
	currentLocation: null
	active: null
	queue: null
	loggedIn: null
	internetConnection: null
	transmitting: ~>
		if @active and @locationAccurate and @internetConnection then return true else return false
	locationAccurate: ~>
		if cordova?
			if @currentLocation.coords.accuracy < 100 then return true else return false
		else 
			return true

	setActiveStatus: (response) ->
		@active = true if response is 'active'
		@queue = true if response is 'queue'