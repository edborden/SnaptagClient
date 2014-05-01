class BotNavView extends Ember.View
	templateName: 'nav/bot'

	didInsertElement: ->
		@_super()
		Ember.$("body").addClass("bot-nav-padding")

	destroy: ->
		Ember.$("body").removeClass("bot-nav-padding")
		@_super()

`export default BotNavView`