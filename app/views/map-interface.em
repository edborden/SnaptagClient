`import ServerTalk from 'appkit/mixins/server-talk'`

class MapInterfaceView extends Ember.View with ServerTalk
	templateName: 'map-interface'

	init: ->
		@_super()
		@context = @
		@session.mapUi = @

	context: null

	session: ~> @controller.session
	me: ~> @session.me

	modal: null
	activeSuspect: null

	showMe: ~> @modal is 'me'
	showWeb: ~> @modal is 'web'
	showPic: ~> @modal is 'pic'
	showNotifications: ~> @modal is 'notifications'
	showExpose: false
	showCounteract: false
	contentSection: true

	webButtonActive: ~>		
		return true if @showWeb
		return true if @showPic and @activeSuspect 

	meButtonActive: ~>
		return true if @showMe
		return true if @showPic and not @activeSuspect

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

	actions:
		toggle: -> @modal = null
		middle: -> @toggleProperty 'contentSection'			
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
			@controller.activeTarget = @activeSuspect
			@controller.history = off
		history: ->
			@controller.history = on
			@controller.activeTarget = @activeSuspect
		showFound: ->
			@showFound = true
			@modal = 'pic'
		showExpose: ->
			@showExpose = true
			@modal = 'pic'
		found: ->
			@getServer('hunts/found_target', {target_id: @activeSuspect.id}).then (response) =>
				if response is "success"
					@session.me.suspects.removeObject @activeSuspect
					@activeSuspect = null
					Bootstrap.GNM.push 'Success', 'Target Found.', 'success'
		expose: ->
			@getServer('hunts/expose', {stalker_id: @activeSuspect.id}).then (response) =>
				if response is "success"
					@session.me.suspects.removeObject @activeSuspect
					@activeSuspect = null
					Bootstrap.GNM.push 'Success', 'Hunter exposed.', 'success'
				else
					@activeSuspect = null
					@session.me.status = 'inactive'
					Bootstrap.GNM.push 'Failed', 'You exposed yourself.', 'warning'
					@controller.transitionToRoute 'inactivemap'
		logout: ->
			@session.close()
			@controller.transitionToRoute 'index'
		notifications: -> @modal = 'notifications'

`export default MapInterfaceView`