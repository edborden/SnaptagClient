class MapController extends Ember.ArrayController
	needs: ['application']
	mapNav: true

	actions:
		join: ->
			@queue = true
			return
#			$.get("http://damp-sea-6022.herokuapp.com/hunts/join.json",
#				(response) =>
#					if response is "active"
#						_this.replaceWith('hunt.index') 
#					if response is "queue"
#						_this.replaceWith('hunt.queue') 
#			"text"
#			)

`export default MapController`