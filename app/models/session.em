attr = DS.attr

class Session extends DS.Model
	token: attr()
	user: DS.belongsTo 'user'

`export default Session`