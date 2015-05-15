class SessionService extends Ember.Service

	store: Ember.inject.service()

	loggedIn: ~> @model?
	model: null
	token: ~> if @model? then @model.token else null
	me: ~> @model.user
	
	active: ~> @me? and @me.status is 'active'
	queue: ~> @me? and @me.status is 'queue'
	inactive: ~> @me? and @me.status is 'inactive'

	refresh: -> @openWithToken @token

	openWithToken: (token) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			@store.find('session', {token:token}).then( 
				(response) => 
					@openWithSession response.firstObject
					resolve()
				(error) => 
					localStorage.clear() if error?
					reject()
			)

	openWithSession: (session) ->
		@model = session
		localStorage.stalkersToken = @token

	openWithUser: (user) ->
		return new Ember.RSVP.Promise (resolve,reject) =>
			@store.createRecord('session', {token:user}).save().then( 
				(response) =>
					@openWithSession response
					resolve "Logged in successfully"
				(error) => 
					console.log 'openWithUser error',error
					reject error.responseJSON
			)

	close: ->
		localStorage.clear()
		@model = null

`export default SessionService`