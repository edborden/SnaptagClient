class InactivemapController extends Ember.ArrayController

	activationqueue: ~> @session.me.activationqueue
	usersCount: ~> @activationqueue.usersCount
	noPlayers: ~> @length is 0
	queueOtherUsersCount: ~> 
		count = @usersCount - 1
		count = "No" if count is 0
		return count
	playersTillStartCount: ~> 12 - @usersCount
	activeQueueZone: ~> @activationqueue.zone.active if @activationqueue?

`export default InactivemapController`