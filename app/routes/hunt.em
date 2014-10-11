class HuntRoute extends Ember.Route
	model: -> @session.me.suspects

`export default HuntRoute`