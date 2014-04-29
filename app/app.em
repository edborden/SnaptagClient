`import Resolver from 'ember/resolver'`

L.Icon.Default.imagePath = 'images/' if cordova?

App = Ember.Application.extend
	LOG_ACTIVE_GENERATION: true
	LOG_MODULE_RESOLVER: true
	LOG_TRANSITIONS: true
	LOG_TRANSITIONS_INTERNAL: true
	LOG_VIEW_LOOKUPS: true
	modulePrefix: 'appkit' 
	Resolver: Resolver['default']

`export default App`