`import ServerTalk from 'appkit/mixins/server-talk'`

class ApplicationRoute extends Ember.Route with ServerTalk

	beforeModel: ->
		@session.setupLocation().then => @session.open localStorage.fbtoken if localStorage.fbtoken?

	actions:
		back: ->
			window.history.go(-1)
		login: ->
			openFB.login =>
				@session.post(localStorage.fbtoken).then( =>
					if @session.me.status is "inactive"
						@transitionTo 'inactivemap'
						Bootstrap.GNM.push 'Logged In', 'You may now Activate.', 'success'
					else if @session.me.status is "queue"
						@transitionTo 'map'
						Bootstrap.GNM.push 'Logged In', 'You are waiting for other Sleepers.', 'success'
					else
						@transitionTo 'map'
						Bootstrap.GNM.push 'Logged In', 'You are now in-game.', 'success'
				)
				{scope:'email,user_photos,user_birthday'}
		join: ->
			@getServer("hunts/join",{location: {lat: @session.currentLocation.coords.latitude,lon: @session.currentLocation.coords.longitude}}).then (response) =>
				@store.pushPayload Ember.$.parseJSON response
				Bootstrap.GNM.push 'Sleeper Activated.', 'You are now in-game.', 'success' if @session.active
				Bootstrap.GNM.push 'Queue entered.', 'You are waiting to play.', 'success' if @session.queue
				@replaceWith 'map' if @session.active
				
		logout: ->
			localStorage.clear()
			@session.loggedIn = false
			@session.active = false
			@replaceWith 'index'
			Bootstrap.GNM.push('Logged Out', null, 'success')
		unjoin: ->
			@session.queue = false
		expose: (user) ->
			@getServer('hunts/expose', {target_id: user.id}).then( (response) =>
				Bootstrap.GNM.push 'Success', 'Target Exposed.', 'success'
				@session.reloadModels()
				@replaceWith 'hunt')
		leave_game: ->
			return
		counteract: (user) ->
			@getServer('hunts/counteract', {hunter_id: user.id}).then( (response) =>
				if response is "success"
					Bootstrap.GNM.push 'Success', 'Hunter compromised.', 'success'
					@session.reloadModels()
					@replaceWith 'hunt'
				else
					@session.active = false
					Bootstrap.GNM.push 'Disavowed', 'Counteraction unsuccessful.', 'warning'
					@replaceWith 'inactivemap')

`export default ApplicationRoute`