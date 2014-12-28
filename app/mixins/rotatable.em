Rotatable = Ember.Mixin.create
	
	rotateBy: ~> 360 / @totalCount * @contentIndex
	style: ~> "-webkit-transform:rotate(" + @rotateBy + "deg);"
	innerStyle: ~> "-webkit-transform:rotate(" + @rotateBy * -1 + "deg);"

	vw: null

	didInsertElement: ->
		@_super()
		@vw = Ember.$('body').width() / 100
		origin = @panelDim+@circleDim
		@element.style.webkitTransformOrigin = "50% " + origin + "px"

`export default Rotatable`