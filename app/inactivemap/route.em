`import ServerTalk from 'stalkers-client/mixins/server-talk'`

class InactivemapRoute extends Ember.Route with ServerTalk

	me: ~> @session.me
	
	beforeModel: ->
		if @session.me? && @session.me.status is 'active'
			@replaceWith 'map'
	model:->
		@store.find 'zone',@loc.object

	actions:
		join: ->
			@transitionTo('loading').then =>
				@getServer("hunts/join",{location: @loc.object}).then (response) =>
					response = Ember.$.parseJSON response
					@store.pushPayload response
					@me.notifyPropertyChange 'status' # fixes status not updating if re-enter queue on same session
					if @session.active
						Bootstrap.GNM.push 'Sleeper Activated.', 'You are now in-game.', 'success'
						@transitionTo 'map'
					else 
						Bootstrap.GNM.push 'Queue entered.', 'You are waiting to play.', 'success'
						@transitionTo 'inactivemap'
		unjoin: ->
			@getServer "hunts/unjoin"
			@me.status = 'inactive'
			Bootstrap.GNM.push 'Queue exited.', 'You are inactive.', 'success'

`export default InactivemapRoute`