`import config from 'stalkers-client/config/environment'`

ServerTalk = Ember.Mixin.create
	
	getServer: (url,data = {},dataType = "text") ->
		return new Ember.RSVP.Promise (resolve) =>
			Ember.$.ajax 
				data: data
				url: config.apiHostName + "/" + url + ".json"
				success: (response) => 
					resolve response
				dataType: dataType
				headers: @headers
				crossDomain: true

	headers: ~>
		if @session.token?
			return {'Authorization': 'Bearer ' + @session.token }
		else
			return {}

`export default ServerTalk`