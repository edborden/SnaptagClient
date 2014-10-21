class SuspectTextView extends Ember.View
	templateName: 'suspect'
	classNames: ['suspect-window-text']	
	top: ~> @parentView.parentView
	didInsertElement: ->
		width = @top.width * 0.95 - 124
		@element.style.width = width + "px"
		@element.style.height = width + "px"
		@element.style.marginLeft = width * -0.5 + "px"
		@element.style.marginTop = width * -0.5 + "px"

	content: ~> @top.activeSuspect
	contentSectionOne: ~> if @top.contentSection is 1 then true else false


`export default SuspectWindowView`