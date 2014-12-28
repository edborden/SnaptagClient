class SessionService extends Ember.Object

	loggedIn: ~> if @model? then return true else return false
	model: null
	token: ~> if @model? then return @model.token else return null
	me: ~> @model.user
	
	active: ~> if @me? and @me.status is 'active' then return true else return false
	queue: ~> if @me? and @me.status is 'queue' then return true else return false
	inactive: ~> if @me? and @me.status is 'inactive' then return true else return false

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