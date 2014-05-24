attr = DS.attr

Location = DS.Model.extend
	lat: attr
	lon: attr
	accuracy: attr
	timestamp: attr
	user: DS.belongsTo 'user'

`export default Location`