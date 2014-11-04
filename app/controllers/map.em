class MapController extends Ember.ArrayController

	needs: ['application']

	latestLocations: ~>	if @activeTarget then [@activeTarget.latestLocation] else @getEach 'latestLocation'
	targetHistoryLocations: ~> @activeTarget.locations if @history is on
	history: Ember.computed.alias 'controllers.application.history'
	activeTarget: Ember.computed.alias 'controllers.application.activeTarget'

`export default MapController`