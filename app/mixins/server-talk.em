ServerTalk = new Ember.Mixin
	
	getServer: (url,data = {},dataType = "text") ->
		return new Ember.RSVP.Promise (resolve) =>
			Ember.$.ajax 
				data: data
				url: "http://damp-sea-6022.herokuapp.com/" + url + ".json"
				success: (response) => 
					resolve response
				dataType: dataType

`export default ServerTalk`