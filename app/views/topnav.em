class TopnavView extends Ember.View
	templateName: 'nav/top'

	didInsertElement: ->
		@_super()
		Ember.$("body").addClass("nav-padding")

	destroy: ->
		Ember.$("body").removeClass("nav-padding")
		@_super()

`export default TopnavView`