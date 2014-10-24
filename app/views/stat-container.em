`import IsRotatable from 'appkit/mixins/is-rotatable'`
`import HasPopup from 'appkit/mixins/has-popup'`

class StatContainerView extends Ember.View with IsRotatable,HasPopup
	classNames: ['stat-container']	
	attributeBindings: ["style"]

	totalCount: 16
	contentIndex: null

`export default StatContainerView`