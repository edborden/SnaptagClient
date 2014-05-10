ServerTalk = new Ember.Mixin
	
	getServer: (url,data = {},dataType = "text") ->
		return new Promise (resolve,reject) ->
			Ember.$.ajax 
				data: data
				url: "http://damp-sea-6022.herokuapp.com/" + url + ".json"
				success: (response) -> 
					resolve response
				dataType: dataType