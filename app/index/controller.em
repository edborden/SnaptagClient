class IndexController extends Ember.ArrayController

	showInstructions: false

	actions:
		instructions: -> 
			@toggleProperty 'showInstructions'
			false

`export default IndexController`