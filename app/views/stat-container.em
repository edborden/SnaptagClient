class StatContainerView extends Ember.View
	classNames: ['stat-container']	
	attributeBindings: ["style"]

	style: ~> "-webkit-transform:#{@mrotate};top:#{@top}px;-webkit-transform-origin:#{@elTransOrigin}"
	innerStyle: ~> "-webkit-transform:#{@innerMrotate};"

	top: ~> (@height - @width) * 0.82
	elTransOrigin: ~> "50% " + ((@circleWidth * 0.5) + 20) + "px"

	+computed parentView.activeSuspect
	active: -> @parentView.activeSuspect is @content

	width: ~> @controller.width
	height: ~> @controller.height
	circleWidth: ~> @parentView.circleWidth

	totalCount: 16
	contentIndex: null
	rotateBy: ~> 360 / @totalCount * @contentIndex
	mrotate: ~> "rotate(" + @rotateBy + "deg)"
	innerRotateBy: ~> @rotateBy * -1
	innerMrotate: ~> "rotate(" + @innerRotateBy + "deg)"

`export default StatContainerView`