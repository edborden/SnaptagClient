attr = DS.attr

class User extends DS.Model

	name: attr()
	exposedCount: attr "number"
	counteractCount: attr "number"
	disavowedCount: attr "number"
	compromisedCount: attr "number"
	smallpic: attr()
	mediumpic: attr()
	largepic: attr()
	influence: attr "number"
	activatedAt: attr "date"
	status: attr()

	suspects: DS.hasMany 'user', {inverse:null}
	targets: DS.hasMany 'user', {inverse:null}

	isTarget: ~> @session.me.targets.any (user) => user is @

	location: ~> @latestLocation.location if @latestLocation?
	locations: DS.hasMany 'location'
	latestLocation: ~> @locations.lastObject if @locations?
	inactiveMapPopupContent: ~> "Active Sleeper who has exposed " + @exposedCount.toString() + " targets and has been hunting since " + moment(@activatedAt).fromNow() + "."

`export default User`