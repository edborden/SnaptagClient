attr = DS.attr

class User extends DS.Model
	name: attr()
	exposed_count: attr "number"
	counteract_count: attr "number"
	compromised_count: attr "number"
	smallpic: attr()
	mediumpic: attr()
	largepic: attr()
	influence: attr "number"

`export default User`