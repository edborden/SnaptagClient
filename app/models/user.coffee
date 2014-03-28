attr = DS.attr

User = DS.Model.extend(
	firstname: attr()
	lastname: attr()
	exposed_count: attr("number")
	counteract_count: attr("number")
	compromised_count: attr("number")
	smallpic: attr()
	mediumpic: attr()
	largepic: attr()
)

`export default User`