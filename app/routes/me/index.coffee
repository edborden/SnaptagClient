MeIndexRoute = Ember.Route.extend(
	model: ->
		this.store.find('user','me')
	renderTemplate: ->
		this.render('usercommon')
)

`export default MeIndexRoute`