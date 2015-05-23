class GrowlerService extends Ember.Service

	messages: Ember.A()

	growl: (code) ->
		message = switch code
			when 1 then 'Logged out'
			when 2 then 'Logged in! You are now in-game.'
			when 3 then 'Logged in! You may now Activate.'
			when 4 then 'Logged in! You are waiting for other players.'
			when 5 then 'You have been activated and are now in-game.'
			when 6 then 'Queue entered. You are waiting to play.'
			when 7 then 'Queue exited. You are inactive.'
			when 8 then 'Success! Target Found.'
			when 9 then 'Success! Stalker exposed.'
			when 10 then 'Failed... You exposed yourself.'
			when 11 then 'You were found by your Stalker!'
			when 12 then 'You were exposed by your target!'
			when 13 then 'You are being watched.'

		@messages.pushObject message

`export default GrowlerService`