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
	lat: attr()
	lon: attr()
	location: ~> return L.latLng @get('lat'), @get('lon')
	locations: DS.hasMany 'location'
	inactiveMapPopupContent: ~> return "Active Sleeper who has exposed " + @get('exposed_count').toString() + " targets and has been hunting since " + moment(@get 'activated_at').fromNow() + "."

`export default User`