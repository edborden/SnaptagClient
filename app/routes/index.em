`import LoginRedirect from 'stalkers-client/mixins/login-redirect'`

class IndexRoute extends Ember.Route with LoginRedirect

	model:->
		@store.find 'zone', @loc.object

	actions:
		login: ->
			@transitionTo('loading').then =>
				@torii.open('facebook-token').then (authorization) =>
					@session.post(authorization.authorizationToken.token).then =>
						if @session.active
							@transitionTo 'map'
							#Bootstrap.GNM.push 'Logged In', 'You are now in-game.', 'success'
						else
							@transitionTo 'inactivemap'
							#Bootstrap.GNM.push 'Logged In', 'You may now Activate.', 'success' if @session.inactive
							#Bootstrap.GNM.push 'Logged In', 'You are waiting for other players.', 'success' if @session.queue

`export default IndexRoute`