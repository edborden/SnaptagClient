attr = DS.attr

Zone = DS.Model.extend
	lat: attr
	lon: attr
	range: attr
	user: DS.belongsTo 'user'

`export default Zone`