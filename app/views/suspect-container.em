`import IsRotatable from 'appkit/mixins/is-rotatable'`

class SuspectContainerView extends Ember.View with IsRotatable
	classNames: ['suspect-container']	
	classNameBindings: ["context.isTarget:target"]
	attributeBindings: ["style"]

	+computed parentView.activeSuspect
	active: -> @parentView.activeSuspect is @content

	totalCount: ~> @_parentView.length
	#@contentIndex defined by collectionview

`export default SuspectContainerView`