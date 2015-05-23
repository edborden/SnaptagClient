class GrowlManagerComponent extends Ember.Component

	messages: null

	actions: 
		remove: (message) ->
			@messages.removeObject message

`export default GrowlManagerComponent`