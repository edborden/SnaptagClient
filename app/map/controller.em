class MapController extends Ember.ArrayController

	activeTarget: null
	history: off
	latestLocations: ~>	if @activeTarget then [@activeTarget.latestLocation] else @getEach 'latestLocation'
	targetHistoryLocations: ~> @activeTarget.locations if @history is on

	actions:
		target: (user) ->
			@activeTarget = user
			@history = off
		history: (user) ->
			@history = on
			@activeTarget = user

`export default MapController`