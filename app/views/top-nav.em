class TopNavView extends Ember.View
	templateName: 'nav/top'

	didInsertElement: ->
		@_super()
		Ember.$("body").addClass("top-nav-padding")

	destroy: ->
		Ember.$("body").removeClass("top-nav-padding")
		@_super()

`export default TopNavView`