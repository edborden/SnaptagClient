attr = DS.attr

Zone = DS.Model.extend
	lat: attr()
	lng: attr()
	range: attr()
	users: DS.hasMany 'user'

`export default Zone`