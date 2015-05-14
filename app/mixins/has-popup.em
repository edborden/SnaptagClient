HasPopup = Ember.Mixin.create
	
	_popoverOpen: ~> @_popoverJqueryObject?

	#Set in template
	popoverContent: null

	#Default behavior is for button to activate popover just one time, then send action on subsequent presses.
	justOnce: yes

	#Set after first popover closes if @once is set
	_noMorePopovers: false

	#Action to send, set in template
	action: null

	popoverPosition: 'top'

	#set in openPopover
	_jqueryObject: null
	_popoverJqueryObject: null

	#object handing opening/closing popups
	popoverHandler: ~> @parentView

	showPopover: ->
		@_jqueryObject = Ember.$(@element)
		@_jqueryObject.popover({content:@popoverContent,placement:@popoverPosition,trigger:'manual'}).popover 'show'
		@_popoverJqueryObject = @_jqueryObject.prop 'nextSibling'
		@popoverHandler.objectWithPopover = @

	removePopover: ->
		@_popoverJqueryObject.remove()
		@_popoverJqueryObject = null
		@_noMorePopovers = true if @justOnce

	click: ->
		if @popoverContent?
			if @_popoverOpen					
				@popoverHandler.removeAnyOpenPopover()
			else
				@popoverHandler.removeAnyOpenPopover()
				unless @_noMorePopovers
					@showPopover()
				else
					@standardClick()
		else
			@standardClick()

	toggleAction: 'toggle'
	standardClick: ->
		@sendAction()
		@sendAction 'toggleAction' if @toggle

`export default HasPopup`