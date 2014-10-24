class InstructionsPanelView extends Ember.View
	classNames: ['instructions-window-panel']

class InstructionsTextView extends Ember.View
	templateName: 'instructions'
	classNames: ['instructions-window-text']	

class InstructionsButtonView extends Ember.View
	classNames: ['instructions-button']
	classNameBindings: ['showInstructions:active:inactive']
	template: Ember.Handlebars.compile "<i class='fa fa-question fa-2x'></i>"
	showInstructions: ~> @parentView.showInstructions

	click: -> @parentView.toggleProperty 'showInstructions'	

class InstructionsWindowView extends Ember.ContainerView

	showInstructions: false

	childViews: ['button']

	panel: new InstructionsPanelView
	text: new InstructionsTextView
	button: new InstructionsButtonView

	+observer showInstructions
	onShow: ->
		if @showInstructions
			@pushObjects [@panel,@text]
		else
			Ember.$(@panel.element).fadeOut 200, => @removeObject @panel
			Ember.$(@text.element).fadeOut 200, => @removeObject @text

`export default InstructionsWindowView`