`import Resolver from 'ember/resolver'`
`import Session from 'appkit/lib/session'`

L.Icon.Default.imagePath = 'images/' if cordova?

class App extends Ember.Application
	LOG_ACTIVE_GENERATION: true
	LOG_MODULE_RESOLVER: true
	LOG_TRANSITIONS: true
	LOG_TRANSITIONS_INTERNAL: true
	LOG_VIEW_LOOKUPS: true
	modulePrefix: 'appkit' 
	Resolver: Resolver['default']
	ready: ->
    	@register('session:current', App.Session, {singleton: true})
    	@inject('controller', 'session', 'session:current')
    	@inject('route', 'session', 'session:current')

`export default App`