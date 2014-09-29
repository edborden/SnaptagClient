ServerTalk = new Ember.Mixin
	
	getServer: (url,data = {},dataType = "text") ->
		return new Ember.RSVP.Promise (resolve) =>
			Ember.$.ajax 
				data: data
				url: "http://damp-sea-6022.herokuapp.com/" + url + ".json"
				success: (response) => 
					resolve response
				dataType: dataType
				headers: @headers

	headers: ~>
		if @session.token?
			return {'Authorization': 'Bearer ' + @session.token }
		else
			return {}

`export default ServerTalk`