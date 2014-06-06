attr = DS.attr

Location = DS.Model.extend
	lat: attr
	lon: attr
	user: DS.belongsTo 'user'

`export default Location`