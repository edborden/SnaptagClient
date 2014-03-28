attr = DS.attr

User = DS.Model.extend(
	firstname: attr()
	lastname: attr()
	completed_count: attr("number")
	roll_up_count: attr("number")
	exposed_count: attr("number")
	smallpic: attr()
	mediumpic: attr()
	largepic: attr()
)

`export default User`