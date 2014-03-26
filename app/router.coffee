Router = Ember.Router.extend()

Router.map( ->
	this.resource('world', ->
		this.route('one')
		this.route('two')
		this.route('three')
		)
	this.resource('me', ->
		this.route('one')
		this.route('two')
		this.route('three')
		)
	this.resource('hunt', ->
		this.route('one')
		this.route('two')
		this.route('three')
		)
)

`export default Router`