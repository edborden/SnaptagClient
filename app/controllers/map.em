`import CenterMap from 'appkit/mixins/center-map'`

class MapController extends Ember.ObjectController with CenterMap

	target1Name: null
	target2Name: null
	target3Name: null

	activeTarget: null
	targetContent: null
	latestLocations: ~>	
		switch @activeTarget
			when null then return @latestLocationsArray
			when 'target1' then return [@latestLocationsArray[0]]
			when 'target2' then return [@latestLocationsArray[1]]
			when 'target3' then return [@latestLocationsArray[2]]


	latestLocationsArray: null

	actions:
		target1: ->
			if @activeTarget is 'target1'
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target1'
		target1History: ->
			if @activeTarget is 'target1'
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target1'
				@targetContent = @content.users[0]		
		target2: ->
			if @activeTarget is 'target2'
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target2'
		target2History: ->
			if @activeTarget is 'target2'
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target2'
				@targetContent = @content.users[1]		
		target3: ->
			if @activeTarget is 'target3'
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target3'
		target3History: ->
			if @activeTarget is 'target3'
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target3'
				@targetContent = @content.users[2]		

	+observer activeTarget
	onActiveTargetChange: ->
		Ember.$("#target1").removeClass 'active'
		Ember.$("#target2").removeClass 'active'
		Ember.$("#target3").removeClass 'active'
		if @activeTarget
			activeID = "#" + @activeTarget
			Ember.$(activeID).addClass 'active'

`export default MapController`