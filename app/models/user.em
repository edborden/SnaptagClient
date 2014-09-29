attr = DS.attr

class User extends DS.Model

	name: attr()
	exposed_count: attr "number"
	counteract_count: attr "number"
	disavowed_count: attr "number"
	compromised_count: attr "number"
	smallpic: attr()
	mediumpic: attr()
	largepic: attr()
	influence: attr "number"
	activated_at: attr "date"
	status: attr()
	suspects: DS.hasMany 'user'
	targets: DS.hasMany 'user'

	location: ~> @latestLocation.location if @latestLocation?
	locations: DS.hasMany 'location'
	latestLocation: ~> @locations.lastObject if @locations?
	inactiveMapPopupContent: ~> "Active Sleeper who has exposed " + @exposed_count.toString() + " targets and has been hunting since " + moment(@activated_at).fromNow() + "."

`export default User`