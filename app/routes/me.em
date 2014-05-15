class MeRoute extends Ember.Route
	model: ->
		@store.find 'user','me'
	renderTemplate: ->
		this.render 'usercommon'

`export default MeRoute`