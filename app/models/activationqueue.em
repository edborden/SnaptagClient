attr = DS.attr

class Activationqueue extends DS.Model
	usersCount: attr "number"
	zone: DS.belongsTo 'zone'

`export default Activationqueue`