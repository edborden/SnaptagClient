class Router extends Ember.Router

Router.map ->
	@route 'instructions'
	@route 'world'
	@route 'me'
	@route 'pic', {path: '/pic/:user_id'}
	@resource 'hunt', ->
		@route 'user', {path: '/user/:user_id'}
		@route 'target', {path: '/target/:user_id'}
		@route 'counteract', {path: '/counteract/:user_id'}
		@route 'expose', {path: '/expose/:user_id'}
	@resource 'map', ->
		@route 'index'
		@route 'two'
		@route 'three'
	@route 'inactivemap'

`export default Router`