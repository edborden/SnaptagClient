`import IsRotatable from 'appkit/mixins/is-rotatable'`

class SuspectContainerView extends Ember.View with IsRotatable
	classNames: ['suspect-container']	
	classNameBindings: ["context.isTarget:target"]
	attributeBindings: ["style"]

	activeSuspect: Ember.computed.alias 'parentView.activeSuspect'
	active: ~> @activeSuspect is @content

	totalCount: ~> @_parentView.length
	#@contentIndex defined by collectionview

	panelDim: ~> 78*@vw/2
	circleDim: ~> 19*@vw/2

	click: ->
		@parentView.contentSection = true unless @parentView.contentSection
		if @active then	@activeSuspect = null else @activeSuspect = @content

`export default SuspectContainerView`