class SuspectContainerView extends Ember.View
	classNames: ['suspect-container']	
	classNameBindings: ["context.isTarget:target"]
	attributeBindings: ["style"]

	style: ~> "-webkit-transform:#{@mrotate};top:#{@top}px;-webkit-transform-origin:#{@elTransOrigin}"
	innerStyle: ~> "-webkit-transform:#{@innerMrotate};"

	top: ~> (@height - @width) * 0.5
	elTransOrigin: ~> "50% " + @elWidth * 0.5 + "px"

	+computed parentView.activeSuspect
	active: -> @parentView.activeSuspect is @content

	width: ~> @controller.width
	height: ~> @controller.height
	elWidth: ~> @parentView.elWidth

	totalCount: ~> @_parentView.length
	rotateBy: ~> 360 / @totalCount * @contentIndex
	mrotate: ~> "rotate(" + @rotateBy + "deg)"
	innerRotateBy: ~> @rotateBy * -1
	innerMrotate: ~> "rotate(" + @innerRotateBy + "deg)"

`export default SuspectContainerView`