class SessionService extends Ember.Service

	store: Ember.inject.service()

	loggedIn: ~> @model?
	model: null
	token: ~> if @model? then @model.token else null
	me: ~> @model.user
	
	active: ~> @me.status is 'active' if @me?
	queue: ~> @me.status is 'queue' if @me?
	inactive: ~> @me.status is 'inactive' if @me?

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