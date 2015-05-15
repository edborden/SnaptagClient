Rotatable = Ember.Mixin.create

	attributeBindings: ["style"]
	
	rotateBy: ~> 360 / @totalCount * @contentIndex
	style: ~> "-webkit-transform:rotate(#{@rotateBy}deg);".htmlSafe()
	innerStyle: ~> "-webkit-transform:rotate(#{@rotateBy * -1}deg);".htmlSafe()

	vw: null

	didInsertElement: ->
		@_super()
		@vw = Ember.$('body').width() / 100
		origin = @panelDim+@circleDim
		@element.style.webkitTransformOrigin = "50% " + origin + "px"

`export default Rotatable`