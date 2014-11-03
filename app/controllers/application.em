class ApplicationController extends Ember.ObjectController

	modal: null
	contentSection: 1
	activeSuspect: null

	showMe: ~> @modal is 'me'
	showWeb: ~> @modal is 'web'
	showPic: ~> @modal is 'pic'
	contentSectionOne: ~> @contentSection is 1
	mapRoute: ~> @currentRouteName is 'map'

	actions:
		toggle: -> @modal = null
		middle: -> @contentSection = switch @contentSection
			when 1 then 2
			when 2 then 1			
		suspect: (suspect) ->
			if @activeSuspect is suspect
				@activeSuspect = null
				@contentSection = 1 unless @contentSection is 1
			else
				@activeSuspect = suspect
				@contentSection = 1 unless @contentSection is 1
		me: ->
			@modal = 'me'
			@activeSuspect = null
			false
		web: ->
			@modal = 'web'
			false
		pic: ->
			@modal = 'pic'
			false			



	init: ->
		@_super()
		document.addEventListener "backbutton", -> navigator.app.exitApp()


`export default ApplicationController`