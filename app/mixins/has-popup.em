HasPopup = new Ember.Mixin
	
	popup: null

	click: ->
		Ember.$(@element).popover {content:@popup,placement:'top'} if @popup

`export default HasPopup`