class ContentPanelComponent extends Ember.Component

	didInsertElement: ->
		height = Ember.$(@element).children().last().height()
		Ember.$(@element).children().first().height(height)

`export default ContentPanelComponent`