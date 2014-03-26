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
		this._super()
		_this = this
		FB.getLoginStatus((response) ->
			if response.status is "connected"
				$.ajaxSetup(
					data: {"token": response.authResponse.accessToken,"facebookid": response.authResponse.userID}
				)
			else
				_this.replaceWith('index')
		)
)

`export default App`