class MapController extends Ember.ObjectController

	target1Name: ~> if @content.users[0]? then return @content.users[0].name else return null
	target2Name: ~> if @content.users[1]? then return @content.users[1].name else return null
	target3Name: ~> if @content.users[2]? then return @content.users[2].name else return null

	activeTarget: null
	targetContent: null
	latestLocations: ~>
		if @activeTarget? then return latestLocationsArray else return null

	latestLocationsArray: null

	actions:
		target1: ->
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
				@targetContent = @content.users[1]
		target3: ->
			if @activeTarget is 'target3'
				@activeTarget = null
				@targetContent = null
			else
				@activeTarget = 'target3'
				@targetContent = @content.users[2]

	+observer activeTarget
	onActiveTargetChange: ->
		if @activeTarget
			Ember.$("#target1").removeClass 'active'
			Ember.$("#target2").removeClass 'active'
			Ember.$("#target3").removeClass 'active'
			activeID = "#" + @activeTarget
			Ember.$(activeID).addClass 'active'
			@latestLocations = null
		else
			Ember.$("#target1").removeClass 'active'
			Ember.$("#target2").removeClass 'active'
			Ember.$("#target3").removeClass 'active'
			@latestLocations = @content.users.map (user) -> user.latestLocation

`export default MapController`