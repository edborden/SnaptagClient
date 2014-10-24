IsRotatable = new Ember.Mixin
	
	rotateBy: ~> 360 / @totalCount * @contentIndex
	style: ~> "-webkit-transform:rotate(" + @rotateBy + "deg);"
	innerStyle: ~> "-webkit-transform:rotate(" + @rotateBy * -1 + "deg);"

`export default IsRotatable`