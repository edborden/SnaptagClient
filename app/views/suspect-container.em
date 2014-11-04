`import IsRotatable from 'appkit/mixins/is-rotatable'`

class SuspectContainerView extends Ember.View with IsRotatable
	classNames: ['suspect-container']	
	classNameBindings: ["context.isTarget:target"]
	attributeBindings: ["style"]

	+computed controller.activeSuspect
	active: -> @controller.activeSuspect is @content

	totalCount: ~> @_parentView.length
	#@contentIndex defined by collectionview

	panelDim: ~> 78*@vw/2
	circleDim: ~> 19*@vw/2

`export default SuspectContainerView`