class IndexController extends Ember.ArrayController

	+observer geolocation.success
	onGeolocationSuccess: -> @transitionToRoute 'index' if @geolocation.success

	showInstructions: false

	actions:
		instructions: -> 
			@toggleProperty 'showInstructions'
			false

`export default IndexController`