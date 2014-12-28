`import NeedsAuthorization from 'stalkers-client/mixins/needs-authorization'`

class MapRoute extends Ember.Route with NeedsAuthorization

	model:->
		@session.me.targets

	actions:
		found: (target) ->
			@transitionTo 'loading'
			@getServer('hunts/found_target', {target_id: target.id}).then (response) =>
				notification = @pushUnparsedNotification response
				@me.suspects.removeObject target
				@me.targetsFoundCount = @me.targetsFoundCount + 1
				Bootstrap.GNM.push 'Success', 'Target Found.', 'success'
				@transitionTo 'map'
		expose: (suspect) ->
			@transitionTo 'loading'
			@getServer('hunts/expose', {stalker_id: suspect.id}).then (response) =>
				notification = @pushUnparsedNotification response
				if notification.subject is "Stalker exposed"
					@me.suspects.removeObject suspect
					@me.targets.removeObject suspect
					@me.notifyPropertyChange 'suspects'
					Bootstrap.GNM.push 'Success', 'Stalker exposed.', 'success'
					@transitionTo 'map'
				if notification.subject is "Exposed self"
					@me.exposedCount = @me.exposedCount + 1
					@goInactive()
					Bootstrap.GNM.push 'Failed', 'You exposed yourself.', 'warning'

	pushUnparsedNotification: (response) ->
		response = Ember.$.parseJSON response
		@pushNotification response

	goInactive: ->
		@me.status = 'inactive'
		@me.suspects.clear()
		@me.targets.clear()		
		@transitionTo 'inactivemap'

`export default MapRoute`