`import Resolver from 'ember/resolver'`
`import Location from 'appkit/libs/location'`

App = Ember.Application.extend(
	LOG_ACTIVE_GENERATION: true
	LOG_MODULE_RESOLVER: true
	LOG_TRANSITIONS: true
	LOG_TRANSITIONS_INTERNAL: true
	LOG_VIEW_LOOKUPS: true
	modulePrefix: 'appkit' 
	Resolver: Resolver['default']
)

window.mylocation = Location.create()

`export default App`