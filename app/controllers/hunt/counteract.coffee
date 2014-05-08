HuntCounteractController = Ember.ObjectController.extend(
	actions:
		counteract: ->
			_this = this
			$.get("http://damp-sea-6022.herokuapp.com/hunts/counteract.json",
				hunter_id: get('id')
				(response) ->
					if response is "success"
						_this.replaceWith('hunt.counteractsuccess') 
					if response is "failure"
						_this.replaceWith('hunt.counteractdisavow') 
			"text"
			)
)

`export default HuntCounteractController`