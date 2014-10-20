class ASuspectView extends Ember.View
	tagName: 'img'
	attributeBindings: ['src']
	src: ~> @content.mediumpic
	content: ~> @parentView.content
	classNames: ['suspect-button']	
	rotateBy: null
	classNameBindings: ["active:active"]
	top: ~> @parentView.parentView.parentView
	click: -> 
		if @top.activeSuspect is @content
			@top.activeSuspect = null
			@top.contentSection = 1 unless @top.contentSection is 1
		else
			@top.activeSuspect = @content
			@top.contentSection = 1 unless @top.contentSection is 1

	+observer rotateBy
	onRotate: ->
		mrotate = "rotate(" + (@rotateBy * -1) + "deg)"
		@element.style.webkitTransform = mrotate

	animateIn: ->
		@element.style.opacity = "1"

	animateOut: ->
		@element.style.opacity = "0"	

	+computed top.activeSuspect
	active: -> @top.activeSuspect is @content

class SuspectContainerView extends Ember.ContainerView
	childViews: [ASuspectView]
	classNames: ['suspect-container']	
	classNameBindings: ["content.isTarget:target"]

	top: ~> @parentView.parentView
	willAnimateIn: ->
		width = @top.width * 0.95
		@element.style.top = (@top.height - width) * 0.5 + "px"
		@element.style.webkitTransformOrigin = "50% " + width * 0.5 + "px"

	rotateBy: null

	animateIn: ->
		@element.style.opacity = "1"

	animateOut: ->
		@element.style.opacity = "0"	

	+observer rotateBy
	onRotate: ->
		@childViews.firstObject.rotateBy = @rotateBy
		mrotate = "rotate(" + @rotateBy + "deg)"
		@element.style.webkitTransform = mrotate

class AllSuspectsView extends Ember.CollectionView
	+volatile
	content: -> @controller.session.me.suspects

	itemViewClass: SuspectContainerView

	didInsertElement: ->
		rotateBy = 360 / @content.length
		@childViews.forEach (suspect,index,array) ->
			suspect.rotateBy = rotateBy * index

	animateOutChildren: ->
		return new Ember.RSVP.Promise (resolve) =>
			@childViews.forEach (suspect,index,array) =>
				suspect.childViews.firstObject.animateOut()
				suspect.animateOut()
				Ember.$(suspect.childViews.firstObject.element).one "webkitTransitionEnd", resolve if index is 0

`export default AllSuspectsView`