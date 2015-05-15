class MapInterfaceComponent extends Ember.Component
	session:Ember.inject.service()
	transmit:Ember.inject.service()

	init: ->
		@_super()
		@context = @

	me: ~> @session.me

	showMe: ~> @modal is 'me'
	showWeb: ~> @modal is 'web'
	showPic: ~> @modal is 'pic'
	showNotifications: ~> @modal is 'notifications'
	contentSection: true

	webButtonActive: ~>		
		return true if @showWeb
		return true if @showPic and @activeSuspect 

	meButtonActive: ~>
		return true if @showMe
		return true if @showPic and not @activeSuspect
		return true if @showNotifications

	locationAccurateText: ~> 
		if @transmit.locationIsAccurate
			"Your location is accurate."
		else
			"Your location is not accurate enough (try turning on your GPS and your WiFi)."

	isTransmittingText: ~>
		if @transmit.isTransmitting
			"You are transmitting your location and accruing influence every 60 seconds."
		else
			"You are not transmitting your location or accruing influence."

	hasInternetConnectionText: ~>
		if @transmit.hasInternetConnection
			"You have an internet connection."
		else
			"You do not have an internet connection."

	+observer me.suspects
	onSuspectsChange: -> @rerender()

	sendTarget: 'target'
	sendHistory: 'history'
	sendLogout: 'logout'
	sendFound: 'found'
	sendExpose: 'expose'

	actions:
		toggle: -> 
			@modal = null
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
			@showFound = false
			@showExpose = false
			if @activeSuspect 
				@modal = 'web' 
			else 
				@modal = 'me'
		target: -> @sendAction 'sendTarget',@activeSuspect
		history: -> @sendAction 'sendHistory',@activeSuspect
		showFound: ->
			@showFound = true
			@modal = 'pic'
		showExpose: ->
			@showExpose = true
			@modal = 'pic'
		found: -> 		
			@sendAction 'sendFound',@activeSuspect
			@activeSuspect = null
		expose: ->
			@sendAction 'sendExpose',@activeSuspect
			@activeSuspect = null
		logout: -> @sendAction 'sendLogout'
		notifications: -> @modal = 'notifications'
		suspectClicked: (suspect) ->
			@contentSection = true unless @contentSection
			if @activeSuspect is suspect then @activeSuspect = null else @activeSuspect = suspect
	
	removeAnyOpenPopover: ->
		if @objectWithPopover?
			@objectWithPopover.removePopover()
			@objectWithPopover = null

	objectWithPopover: null

`export default MapInterfaceComponent`