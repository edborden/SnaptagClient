class MapController extends Ember.ArrayController

	init: ->
		@_super()
		@session.mapController = @

	activeTarget: null
	history: off
	latestLocations: ~>	if @activeTarget then [@activeTarget.latestLocation] else @getEach 'latestLocation'
	targetHistoryLocations: ~> @activeTarget.locations if @history is on

`export default MapController`