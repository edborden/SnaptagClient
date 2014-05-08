class MapController extends Ember.ArrayController
	needs: 'application'
	mapNav: true

	actions:
		join: ->
			@controllers.application.join()

`export default MapController`