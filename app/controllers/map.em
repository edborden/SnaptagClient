class MapController extends Ember.ArrayController

	width: ~> Ember.$(window).width()
	height: ~> Ember.$(window).height()

	target1: ~> @objectAt(0) if @length >= 1
	target2: ~> @objectAt(1) if @length >= 2
	target3: ~> @objectAt(2) if @length is 3

	activeTarget: null
	latestLocations: ~>	if @activeTarget then [@activeTarget.latestLocation] else @getEach 'latestLocation'
	targetHistoryLocations: ~> @activeTarget.locations if @history is on
	history: off

	actions:
		target1: ->
			if @activeTarget is @target1
				@activeTarget = null
				@history = off
			else if @activeTarget
				@activeTarget = @target1
				@history = off
			else
				@activeTarget = @target1
			@activeCSSHandler()
		target1History: ->
			if @activeTarget is @target1 and @history
				@activeTarget = null
				@history = off
			else
				@activeTarget = @target1
				@history = on
			@activeCSSHandler()
		target2: ->
			if @activeTarget is @target2
				@activeTarget = null
				@history = off
			else if @activeTarget
				@activeTarget = @target2
				@history = off
			else
				@activeTarget = @target2
			@activeCSSHandler()
		target2History: ->
			if @activeTarget is @target2 and @history
				@activeTarget = null
				@history = off
			else
				@activeTarget = @target2
				@history = on	
			@activeCSSHandler()
		target3: ->
			if @activeTarget is @target3
				@activeTarget = null
				@history = off
			else if @activeTarget
				@activeTarget = @target3
				@history = off
			else
				@activeTarget = @target3
			@activeCSSHandler()
		target3History: ->
			if @activeTarget is @target3 and @history
				@activeTarget = null
				@history = off
			else
				@activeTarget = @target3
				@history = on
			@activeCSSHandler()

	activeCSSHandler: ->
		Ember.$("#target1").removeClass 'active'
		Ember.$("#target1History").removeClass 'active'
		Ember.$("#target2").removeClass 'active'
		Ember.$("#target2History").removeClass 'active'
		Ember.$("#target3").removeClass 'active'
		Ember.$("#target3History").removeClass 'active'
		activeID = "#"
		switch @activeTarget
			when @target1 then activeID = activeID + "target1"
			when @target2 then activeID = activeID + "target2"
			when @target3 then activeID = activeID + "target3"
		Ember.$(activeID).addClass 'active'
		if @history
			activeID = activeID + "History"
			Ember.$(activeID).addClass 'active'

`export default MapController`