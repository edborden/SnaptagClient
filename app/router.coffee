Router = Ember.Router.extend()

Router.map( ->
	this.resource('inside', ->
		this.route('world')
		this.route('me')
		this.route('hunt')
	)
)

`export default Router`