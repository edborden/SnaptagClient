class HuntIndexRoute extends Ember.Route
	model: ->
		this.store.find('user',{ web: true })

`export default HuntIndexRoute`