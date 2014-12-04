`import ServerTalk from 'appkit/mixins/server-talk'`
`import RealTime from 'appkit/mixins/real-time'`

class ApplicationRoute extends Ember.Route with ServerTalk, RealTime

	me: ~> @session.me

	beforeModel: ->
		@session.setupLocation().then => @session.open localStorage.fbtoken if localStorage.fbtoken?
	model: -> @me

	actions:
		login: ->
			openFB.login =>
				@session.post(localStorage.fbtoken).then =>
					if @session.active
						@transitionTo 'map'
						Bootstrap.GNM.push 'Logged In', 'You are now in-game.', 'success'
					else
						@transitionTo 'inactivemap'
						Bootstrap.GNM.push 'Logged In', 'You may now Activate.', 'success' if @session.inactive
						Bootstrap.GNM.push 'Logged In', 'You are waiting for other players.', 'success' if @session.queue
				{scope:'email'}
		join: ->
			@getServer("hunts/join",{location: {lat: @session.currentLocation.coords.latitude,lng: @session.currentLocation.coords.longitude}}).then (response) =>
				@store.pushPayload Ember.$.parseJSON response
				Bootstrap.GNM.push 'Sleeper Activated.', 'You are now in-game.', 'success' if @session.active
				Bootstrap.GNM.push 'Queue entered.', 'You are waiting to play.', 'success' if @session.queue
				@replaceWith 'map' if @session.active				
		#unjoin: ->
		#	@session.queue = false
		found: (target) ->
			@getServer('hunts/found_target', {target_id: target.id}).then (response) =>
				notification = @pushUnparsedNotification response
				@me.suspects.removeObject target
				@me.targetsFoundCount = @me.targetsFoundCount + 1
				Bootstrap.GNM.push 'Success', 'Target Found.', 'success'
		expose: (suspect) ->
			@getServer('hunts/expose', {stalker_id: suspect.id}).then (response) =>
				notification = @pushUnparsedNotification response
				if notification.subject is "Stalker exposed"
					@me.suspects.removeObject suspect
					@me.targets.removeObject suspect
					@me.notifyPropertyChange 'suspects'
					Bootstrap.GNM.push 'Success', 'Stalker exposed.', 'success'
				if notification.subject is "Exposed self"
					@me.exposedCount = @me.exposedCount + 1
					@goInactive()
					Bootstrap.GNM.push 'Failed', 'You exposed yourself.', 'warning'

		logout: ->
			@session.close()
			@transitionTo 'index'

	pushUnparsedNotification: (response) ->
		response = Ember.$.parseJSON response
		@pushNotification response

	goInactive: ->
		@me.status = 'inactive'
		@me.suspects.clear()
		@me.targets.clear()		
		@transitionTo 'inactivemap'

`export default ApplicationRoute`