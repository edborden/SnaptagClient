class Router extends Ember.Router

Router.map ->
	this.route 'instructions'
	this.route 'world'
	this.route 'me'
	this.route 'pic', {path: '/pic/:user_id'}
	this.resource 'hunt', ->
		this.route 'user', {path: '/user/:user_id'}
		this.route 'target', {path: '/target/:user_id'}
		this.route 'counteract', {path: '/counteract/:user_id'}
		this.route 'expose', {path: '/expose/:user_id'}
		this.route 'counteractsuccess'
		this.route 'counteractdisavow'
	this.route 'map'
	this.route 'inactivemap'

`export default Router`