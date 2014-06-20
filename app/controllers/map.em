class MapController extends Ember.ObjectController

	target1Name: ~> if @content.content[0]? then return @content.content[0].name else return null
	target2Name: ~> if @content.content[1]? then return @content.content[1].name else return null
	target3Name: ~> if @content.content[2]? then return @content.content[2].name else return null

	activeTarget: null
	latestLocations: ~>	
		switch @activeTarget
			when null then return @latestLocationsArray
			when 'target1' then return [@latestLocationsArray[0]]
			when 'target2' then return [@latestLocationsArray[1]]
			when 'target3' then return [@latestLocationsArray[2]]

	latestLocationsArray: ~> if @content.content? then return @content.content.map (user) -> user.locations.content[user.locations.content.length - 1] else return null

	targetContent: null

	actions:
		target1: ->
			if @activeTarget is 'target1'
				@activeTarget = null
				@targetContent = null
			else if @activeTarget
				@activeTarget = 'target1'
				@targetContent = null
			else
				@activeTarget = 'target1'
			@activeCSSHandler()
		target1History: ->
			if @activeTarget is 'target1' and @targetContent
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target1'
				@targetContent = @content.content[0].locations
			@activeCSSHandler()
		target2: ->
			if @activeTarget is 'target2'
				@activeTarget = null
				@targetContent = null
			else if @activeTarget
				@activeTarget = 'target2'
				@targetContent = null
			else
				@activeTarget = 'target2'
			@activeCSSHandler()
		target2History: ->
			if @activeTarget is 'target2' and @targetContent
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target2'
				@targetContent = @content.content[1].locations	
			@activeCSSHandler()
		target3: ->
			if @activeTarget is 'target3'
				@activeTarget = null
				@targetContent = null
			else if @activeTarget
				@activeTarget = 'target3'
				@targetContent = null
			else
				@activeTarget = 'target3'
			@activeCSSHandler()
		target3History: ->
			if @activeTarget is 'target3' and @targetContent
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target3'
				@targetContent = @content.content[2].locations	
			@activeCSSHandler()

	activeCSSHandler: ->
		Ember.$("#target1").removeClass 'active'
		Ember.$("#target1History").removeClass 'active'
		Ember.$("#target2").removeClass 'active'
		Ember.$("#target2History").removeClass 'active'
		Ember.$("#target3").removeClass 'active'
		Ember.$("#target3History").removeClass 'active'
		if @activeTarget
			activeID = "#" + @activeTarget
			Ember.$(activeID).addClass 'active'
		if @targetContent
			activeID = "#" + @activeTarget + "History"
			Ember.$(activeID).addClass 'active'

`export default MapController`