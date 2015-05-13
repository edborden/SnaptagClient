class SessionService extends Ember.Object

	loggedIn: ~> @model?
	model: null
	token: ~> if @model? then @model.token else null
	me: ~> @model.user
	
	active: ~> @me? and @me.status is 'active'
	queue: ~> @me? and @me.status is 'queue'
	inactive: ~> @me? and @me.status is 'inactive'

	open: ->
		return new Ember.RSVP.Promise (resolve) =>
			if localStorage.fbtoken?
				@store.find('session', {token: localStorage.fbtoken}).then(
					(response) => 
						@model = response.objectAt(0)
						resolve()
					(error) -> 
						localStorage.clear() if error.status is 401
						resolve()
				)
			else 
				resolve()

	post: (token) ->
		return new Ember.RSVP.Promise (resolve) =>
			@store.createRecord('session',{token: token}).save().then(
				(response) => 
					@model = response
					localStorage.fbtoken = @token
					resolve()
				(error) => 
					@close() if error.status is 401
					resolve()
			)

	close: ->
		localStorage.clear()
		@model = null

`export default SessionService`