`import config from './config/environment'`

class Router extends Ember.Router
	location: config.locationType

Router.map ->
	@route 'map'
	@route 'inactivemap'
	@route 'update'

`export default Router`