attr = DS.attr

class Version extends DS.Model

	revision: attr "number"
	platform: attr()

`export default Version`