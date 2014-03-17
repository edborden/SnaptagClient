`import Resolver from 'ember/resolver'`

App = Ember.Application.extend(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  modulePrefix: 'appkit' 
  Resolver: Resolver['default']
)

Ember.Route.reopen(
	beforeModel: ->
		_this = this
		this._super()
		FB.getLoginStatus( (response) ->
			if response.status isnt 'connected'
				_this.replaceWith('login')
		)
)

`export default App`