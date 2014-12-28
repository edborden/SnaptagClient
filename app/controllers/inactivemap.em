`import NeedsAuthorization from 'stalkers-client/mixins/needs-authorization'`

class InactivemapController extends Ember.ArrayController with NeedsAuthorization

	activationqueue: ~> @session.me.activationqueue
	usersCount: ~> @activationqueue.usersCount
	noPlayers: ~> @length is 0
	queueOtherUsersCount: ~> 
		count = @usersCount - 1
		count = "No" if count is 0
		return count
	playersTillStartCount: ~> 12 - @usersCount
	activeQueueZone: ~> @activationqueue.zone.active

`export default InactivemapController`