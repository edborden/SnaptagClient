`import Rotatable from 'stalkers-client/mixins/rotatable'`
`import HasPopup from 'stalkers-client/mixins/has-popup'`

class SmallButtonComponent extends Ember.Component with Rotatable, HasPopup
	classNames: ['small-button-container']	
	attributeBindings: ["style"]
	layoutName: 'components/small-button'

	totalCount: 16

	sendAction: ->
		@target.send "toggle" unless @noToggle
		@_super()

`export default SmallButtonComponent`