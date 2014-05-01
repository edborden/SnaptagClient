class BackButtonComponent extends Ember.Component
	didInsertElement: ->
		@_super()
		Ember.$("body").addClass("top-nav-padding")

	destroy: ->
		Ember.$("body").removeClass("top-nav-padding")
		@_super()

	actions:
		back: ->
			window.history.go(-1)

`export default BackButtonComponent`