`import Resolver from 'ember/resolver'`
`import Facebook from 'appkit/mixins/facebook'`

App = Ember.Application.extend(Facebook,
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  modulePrefix: 'appkit' 
  Resolver: Resolver['default']
)

App.initializer(
  name: 'authentication'
  initialize: (container, application) ->
    Ember.SimpleAuth.setup(container, application)
)
`export default App`