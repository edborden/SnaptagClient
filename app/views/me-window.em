class MePanelView extends Ember.View
	classNames: ['me-window-panel']

class MeTextView extends Ember.View
	templateName: 'me'
	classNames: ['me-window-text']	

class MeButtonView extends Ember.View
	classNames: ['me-button']
	classNameBindings: ['showMe:active:inactive']
	tagName: 'img'
	showMe: ~> @parentView.showMe
	attributeBindings: ['src']
	src: ~> @context.mediumpic
	click: -> @parentView.toggleProperty 'showMe'	

class MeWindowView extends Ember.ContainerView

	showMe: false

	childViews: ['button']

	panel: new MePanelView
	text: new MeTextView
	button: new MeButtonView

	+observer showMe
	onShow: ->
		if @showMe
			@pushObjects [@panel,@text]
		else
			@removeObject @panel
			@removeObject @text

`export default MeWindowView`