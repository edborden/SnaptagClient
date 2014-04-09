HuntIndexRoute = Ember.Route.extend(

	beforeModel: ->
		_this = this
		$.get("http://damp-sea-6022.herokuapp.com/users/status.json", (response) -> 
			if response is 'inactive'
				_this.replaceWith('hunt.join') 
			if response is 'queue'
				_this.replaceWith('hunt.queue')
		"text"
		)
	model: ->
		this.store.find('user',{ web: true })
)

`export default HuntIndexRoute`