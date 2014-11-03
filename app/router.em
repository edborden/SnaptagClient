class Router extends Ember.Router

Router.map ->
	@route 'instructions'
	@route 'world'
	@route 'pic', {path: '/pic/:user_id'}
	@route 'map'
	@route 'inactivemap'

`export default Router`