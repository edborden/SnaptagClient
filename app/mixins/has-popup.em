HasPopup = new Ember.Mixin
	
	popup: null

	click: ->
		Ember.$(@element).popover {content:@popupText,placement:'top'} if @popup

`export default HasPopup`