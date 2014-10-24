`import IsRotatable from 'appkit/mixins/is-rotatable'`

class ButtonContainerView extends Ember.View with IsRotatable
	classNames: ['stat-container']	
	attributeBindings: ["style"]

	totalCount: 16
	contentIndex: null

	action: null

	click: ->
		if @action
			@parentView.send "toggle" 
			@controller.send @action, @parentView.activeSuspect

`export default ButtonContainerView`