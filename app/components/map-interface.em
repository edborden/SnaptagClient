class MapInterfaceComponent extends Ember.Component
	layoutName: 'map-interface'

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

	+observer me.suspects
	onSuspectsChange: -> @rerender()

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
			@showFound = false
			@showExpose = false
			if @activeSuspect 
				@modal = 'web' 
			else 
				@modal = 'me'
		target: -> @controller.send 'target',@activeSuspect
		history: -> @controller.send 'history',@activeSuspect
		showFound: ->
			@showFound = true
			@modal = 'pic'
		showExpose: ->
			@showExpose = true
			@modal = 'pic'
		found: -> 		
			@controller.send 'found',@activeSuspect
			@activeSuspect = null
		expose: ->
			@controller.send 'expose',@activeSuspect
			@activeSuspect = null
		logout: -> @controller.send 'logout'
		notifications: -> @modal = 'notifications'
	
	removeAnyOpenPopover: ->
		if @objectWithPopover?
			@objectWithPopover.removePopover()
			@objectWithPopover = null

	objectWithPopover: null

`export default MapInterfaceComponent`