`import IsRotatable from 'appkit/mixins/is-rotatable'`

class ButtonContainerComponent extends Ember.View with IsRotatable
	classNames: ['stat-container']	
	attributeBindings: ["style"]
	layoutName: 'components/stat-container'

	totalCount: 16

	action: null

	click: ->
		if @action
			@parentView.send "toggle" 
			@controller.send @action, @parentView.activeSuspect

`export default ButtonContainerComponent`