class SuspectPanelView extends Ember.View
	width: ~> @top.width * 0.95 - 124
	classNames: ['suspect-window-panel']
	#templateName: 'web/panel'Ember.Handlebars.compile "<svg><circle r='100' cx='" + (@width * 0.5) + "' cy='" + @width * 0.5 + "' stroke='white' fill='transparent'/></svg>"
	halfWidth: ~> @width *0.5
	top: ~> @parentView.parentView
	templateName: 'web/panel'
	willAnimateIn: ->
		@element.style.width = @width + "px"
		@element.style.height = @width + "px"
		@element.style.marginLeft = @width * -0.5 + "px"
		@element.style.marginTop = @width * -0.5 + "px"

	animateIn: ->
		@element.style.opacity = ".6"

	animateOut: ->
		@element.style.opacity = "0"

class SuspectTextView extends Ember.View
	templateName: 'suspect'
	classNames: ['suspect-window-text']	
	top: ~> @parentView.parentView
	willAnimateIn: ->
		width = @top.width * 0.95 - 124
		@element.style.width = width + "px"
		@element.style.height = width + "px"
		@element.style.marginLeft = width * -0.5 + "px"
		@element.style.marginTop = width * -0.5 + "px"

	animateIn: ->
		@element.style.opacity = "1"

	animateOut: ->
		@element.style.opacity = "0"

	content: ~> @top.activeSuspect
	contentSectionOne: ~> if @top.contentSection is 1 then true else false

class MiddleButtonView extends Ember.View
	classNames: ['middle-button']
	top: ~> @parentView.parentView		
	#template: Ember.Handlebars.compile "<i class='fa fa-eye fa-2x'></i>"
	click: -> @top.contentSection = switch @top.contentSection
		when 1 then 2
		when 2 then 1
	#classNameBindings: ['parentView.showWeb:active']

	animateIn: ->
		@element.style.opacity = "1"

	animateOut: ->
		@element.style.opacity = "0"

class SuspectWindowView extends Ember.ContainerView

	childViews: ['panel','text','button']

	panel: new SuspectPanelView
	text: new SuspectTextView
	button: new MiddleButtonView



	animateOutChildren: ->
		return new Ember.RSVP.Promise (resolve) =>
			@childViews.forEach (view,index) =>
				view.animateOut()
				Ember.$(view.element).one "webkitTransitionEnd", resolve if index is 0

`export default SuspectWindowView`