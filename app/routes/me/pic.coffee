MePicRoute = Ember.Route.extend(
	model: ->
		this.store.find('user','me')
	renderTemplate: ->
		this.render('pic')
)

`export default MePicRoute`