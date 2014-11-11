`import IsRotatable from 'appkit/mixins/is-rotatable'`

class SmallButtonComponent extends Ember.View with IsRotatable
	classNames: ['small-button-container']	
	attributeBindings: ["style"]
	layoutName: 'components/small-button'

	totalCount: 16

	popup: null
	popover: null
	action: null

	click: ->
		if @popup
			if @popover
				Ember.$(".popover").remove()
				#@popover = false
				#popup only appears one time on purpose, so that tooltips can be displayed on buttons that might need an action explained
			else
				Ember.$(".popover").remove()
				Ember.$(@element).popover({content:@popup,placement:'top'}).popover 'show'
				@popover = true
		else
			if @action
				@parentView.send "toggle" unless @noToggle
				@parentView.send @action

`export default SmallButtonComponent`