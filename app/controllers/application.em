class ApplicationController extends Ember.ObjectController

	modal: null
	contentSection: 1
	activeSuspect: null
	activeTarget: null
	history: off

	showMe: ~> @modal is 'me'
	showWeb: ~> @modal is 'web'
	showPic: ~> @modal is 'pic'
	contentSectionOne: ~> @contentSection is 1
	mapRoute: ~> @currentRouteName is 'map'

	webButtonActive: ~>		
		return true if @showWeb
		return true if @showPic and @activeSuspect 

	meButtonActive: ~>
		return true if @showMe
		return true if @showPic and not @activeSuspect

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
			unless @showMe
				@modal = 'me'
				@activeSuspect = null
			else
				@modal = null
		web: ->
			unless @showWeb
				@modal = 'web'
			else
				@modal = null
		pic: ->
			@modal = 'pic'
			false			
		closePic: ->
			if @activeSuspect then @modal = 'web' else @modal = 'me'
		target: ->
			@activeTarget = @activeSuspect
			@history = off
			false
		history: ->
			@activeTarget = @activeSuspect
			@history = on
			false
		expose: ->
			@getServer('hunts/expose', {target_id: @activeSuspect.id}).then( (response) =>
				Bootstrap.GNM.push 'Success', 'Target Exposed.', 'success'
				@session.reloadModels()
				@replaceWith 'hunt')
		counteract: ->
			@getServer('hunts/counteract', {hunter_id: @activeSuspect.id}).then( (response) =>
				if response is "success"
					Bootstrap.GNM.push 'Success', 'Hunter compromised.', 'success'
					@session.reloadModels()
					@replaceWith 'hunt'
				else
					@session.active = false
					Bootstrap.GNM.push 'Disavowed', 'Counteraction unsuccessful.', 'warning'
					@replaceWith 'inactivemap')

	init: ->
		@_super()
		document.addEventListener "backbutton", -> navigator.app.exitApp()

`export default ApplicationController`