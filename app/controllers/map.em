class MapController extends Ember.ArrayController

	activeTarget: null
	latestLocations: ~>	if @activeTarget then [@activeTarget.latestLocation] else @getEach 'latestLocation'
	targetHistoryLocations: ~> @activeTarget.locations if @history is on
	history: off

	actions:
		target: (target) ->
			@activeTarget = target
			@history = off
			false
		history: (target) ->
			@activeTarget = target
			@history = on
			false

`export default MapController`