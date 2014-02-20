Router = Ember.Router.extend()

Router.map( ->
	this.resource('inside', ->
		this.route('first')
		this.route('second')
		this.route('third')
	)
)

`export default Router`