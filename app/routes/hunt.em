class HuntRoute extends Ember.Route
	model: ->
		Ember.RSVP.hash
			web_without_targets: this.store.find('user',{ web_without_targets: true })
			targets: this.store.find('user',{ targets: true })

`export default HuntRoute`