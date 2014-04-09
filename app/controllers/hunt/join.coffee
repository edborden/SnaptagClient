HuntJoinController = Ember.ObjectController.extend(
	actions:
		join: ->
			_this = this
			$.get("http://damp-sea-6022.herokuapp.com/hunts/join.json",
				(response) ->
					if response is "active"
						_this.replaceWith('hunt.index') 
					if response is "queue"
						_this.replaceWith('hunt.queue') 
			"text"
			)
)

`export default HuntJoinController`