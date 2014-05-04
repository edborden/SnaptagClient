class MapController extends Ember.ArrayController
	needs: ['application']
	mapNav: true

	actions:
		join: ->
			Ember.$.ajax 
				url: "http://damp-sea-6022.herokuapp.com/hunts/join.json"
				success: @setActiveStatus(response)
				dataType: "text"

`export default MapController`