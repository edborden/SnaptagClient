`import IsRotatable from 'appkit/mixins/is-rotatable'`

class OutsideButtonComponent extends Ember.View with IsRotatable
	classNames: ['suspect-container']	
	attributeBindings: ["style"]

	totalCount: 16

`export default OutsideButtonComponent`