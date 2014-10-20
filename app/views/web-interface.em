`import AllSuspectsView from 'appkit/views/web/all-suspects'`
`import SuspectWindowView from 'appkit/views/web/suspect-window'`
`import WebButtonView from 'appkit/views/web/button'`

class WebInterfaceView extends Ember.ContainerView
	width: ~> Ember.$(window).width()
	height: ~> Ember.$(window).height()
	childViews: ['button']

	button: new WebButtonView

	# some wonky stuff here, where I cannot add a collectionview into a containerview like I would any other normal view. have to call createchildview with volatile
	+volatile
	allSuspects: -> @createChildView AllSuspectsView

	+volatile
	suspectWindow: -> @createChildView SuspectWindowView
	contentSection: 1
	activeSuspect: null
	showWeb: false

	+observer showWeb
	onShowWebChange: ->
		if @showWeb
			@pushObjects [ @suspectWindow,@allSuspects]
		else
			@activeSuspect = null
			suspectWindow = @objectAt(1)
			allSuspects = @objectAt(2)
			suspectWindow.animateOutChildren().then => @removeObject suspectWindow
			allSuspects.animateOutChildren().then => @removeObject allSuspects

`export default WebInterfaceView`