attr = DS.attr

class User extends DS.Model

	name: attr()
	targetsFoundCount: attr "number"
	foundCount: attr "number"
	stalkersExposedCount: attr "number"
	exposedCount: attr "number"
	smallpic: attr()
	mediumpic: attr()
	largepic: attr()
	stealth: attr "number"
	activatedAt: attr "date"
	status: attr()

	activationqueue: DS.belongsTo 'activationqueue'
	suspects: DS.hasMany 'user', {inverse:null}
	targets: DS.hasMany 'user', {inverse:null}
	notifications: DS.hasMany 'notification'

	isTarget: ~> @session.me.targets.any (user) => user is @

	location: ~> @latestLocation.location if @latestLocation?
	locations: DS.hasMany 'location'
	latestLocation: ~> @locations.lastObject if @locations?
	inactiveMapPopupContent: ~> "Active Stalker who has found " + @targetsFoundCount.toString() + " targets and has been hunting since " + moment(@activatedAt).fromNow() + "."

	unreadNotifications: ~>
		array = []
		@notifications.forEach (notification) -> array.pushObject notification unless notification.read
		return array

`export default User`