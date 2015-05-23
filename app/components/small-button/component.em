`import Rotatable from 'stalkers-client/mixins/rotatable'`
`import HasPopup from 'stalkers-client/mixins/has-popup'`

class SmallButtonComponent extends Ember.Component with Rotatable, HasPopup
	classNames: ['small-button-container']	
	layoutName: 'components/small-button'
	classNameBindings: ['inside']

	totalCount: 16

	circleDim: ~> 10*@vw/2
	panelDim: ~> 
		if @inside
			78*@vw/4
		else
			78*@vw/2



`export default SmallButtonComponent`