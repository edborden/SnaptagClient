`import BgFade from 'appkit/mixins/bg-fade'`
`import ContentFade from 'appkit/mixins/content-fade'`

class MePanelView extends Ember.View with BgFade
	classNames: ['me-window-panel']

class MeTextView extends Ember.View with ContentFade
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
			Ember.$(@panel.element).fadeOut 200, => @removeObject @panel
			Ember.$(@text.element).fadeOut 200, => @removeObject @text

`export default MeWindowView`