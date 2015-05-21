attr = DS.attr

class Session extends DS.Model
	token: attr()
	user: DS.belongsTo 'user'
	regId: attr()
	platform: attr()

`export default Session`