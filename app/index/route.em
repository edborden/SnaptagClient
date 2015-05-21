class IndexRoute extends Ember.Route

	beforeModel: ->
		Ember.$(".center-spinner").hide()
		if @session.active
			console.log 'transitionTo map'
			@replaceWith 'map' 
		else if @session.inactive or @session.queue
			console.log 'transitionTo inactivemap'
			@replaceWith 'inactivemap'

	model:-> 
		console.log 'geo success?',@geolocation.success
		if @geolocation.success
			@store.find 'zone', @geolocation.object
		else
			[]

`export default IndexRoute`