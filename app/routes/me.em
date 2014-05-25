class MeRoute extends Ember.Route
	model: ->
		@store.find 'user','me'

`export default MeRoute`