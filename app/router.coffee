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
		this.route('pic')
		)
	this.resource('hunt', ->
		this.route('user', {path: '/user/:user_id'})
		this.route('counteract', {path: '/counteract/:user_id'})
		this.route('locate', {path: '/locate/:user_id'})
		this.route('expose', {path: '/expose/:user_id'})
		this.route('join')
		this.route('queue')
		this.route('counteractsuccess')
		this.route('counteractdisavow')
	)
)

`export default Router`