class ContentPanelComponent extends Ember.Component
	
	didInsertElement: ->
		height = Ember.$(@element).children().first().height()
		marginTop = height * -0.5 + "px"
		child.style.marginTop = marginTop for child in Ember.$(@element).children()
		@_super()

`export default ContentPanelComponent`