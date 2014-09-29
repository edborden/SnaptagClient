attr = DS.attr

Zone = DS.Model.extend
	lat: attr()
	lon: attr()
	range: attr()
	users: DS.hasMany 'user'

`export default Zone`