`import ServerTalk from 'appkit/mixins/server-talk'`

class ApplicationController extends Ember.ObjectController with ServerTalk

	modal: null
	activeSuspect: null
	activeTarget: null
	history: off

	showMe: ~> @modal is 'me'
	showWeb: ~> @modal is 'web'
	showPic: ~> @modal is 'pic'
	showExpose: false
	showCounteract: false
	contentSectionOne: true
	mapRoute: ~> @currentRouteName is 'map'

	webButtonActive: ~>		
		return true if @showWeb
		return true if @showPic and @activeSuspect 

	meButtonActive: ~>
		return true if @showMe
		return true if @showPic and not @activeSuspect

	actions:
		toggle: -> @modal = null
		middle: -> @toggleProperty 'contentSectionOne'			
		suspect: (suspect) ->
			if @activeSuspect is suspect
				@activeSuspect = null
				@contentSection = true unless @contentSection
			else
				@activeSuspect = suspect
				@contentSection = true unless @contentSection
		me: ->
			if @meButtonActive
				@modal = null
			else
				@modal = 'me'
				@activeSuspect = null
		web: -> if @showWeb then @modal = null else @modal = 'web'
		pic: -> @modal = 'pic'			
		closePic: -> 
			@showCounteract = false
			@showExpose = false
			if @activeSuspect 
				@modal = 'web' 
			else 
				@modal = 'me'
		target: ->
			@activeTarget = @activeSuspect
			@history = off
		history: ->
			@history = on
			@activeTarget = @activeSuspect
		exposeWindow: ->
			@showExpose = true
			@modal = 'pic'
		counteractWindow: ->
			@showCounteract = true
			@modal = 'pic'
		expose: ->
			@getServer('hunts/expose', {target_id: @activeSuspect.id}).then (response) =>
				if response is "success"
					@session.me.suspects.removeObject @activeSuspect
					@activeSuspect = null
					Bootstrap.GNM.push 'Success', 'Target Exposed.', 'success'
		counteract: ->
			@getServer('hunts/counteract', {hunter_id: @activeSuspect.id}).then (response) =>
				if response is "success"
					@session.me.suspects.removeObject @activeSuspect
					@activeSuspect = null
					Bootstrap.GNM.push 'Success', 'Hunter compromised.', 'success'
				else
					@activeSuspect = null
					@session.me.status = 'inactive'
					Bootstrap.GNM.push 'Disavowed', 'Counteraction unsuccessful.', 'warning'
					@transitionTo 'inactivemap'

	locationAccurateText: ~> 
		if @session.locationIsAccurate
			"Your location is accurate."
		else
			"Your location is not accurate enough (try turning on your GPS and your WiFi)."

	isTransmittingText: ~>
		if @session.isTransmitting
			"You are transmitting your location and accruing influence every 60 seconds."
		else
			"You are not transmitting your location or accruing influence."

	hasInternetConnectionText: ~>
		if @session.hasInternetConnection
			"You have an internet connection."
		else
			"You do not have an internet connection."

	### BACK BUTTON ###

	init: ->
		@_super()
		document.addEventListener "backbutton", -> navigator.app.exitApp()

`export default ApplicationController`