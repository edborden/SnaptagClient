attr = DS.attr

Location = DS.Model.extend
	latitude: attr
	longitude: attr
	accuracy: attr
	timestamp: attr
	user: DS.belongsTo 'user'

`export default Location`