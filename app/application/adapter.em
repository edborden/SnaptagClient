`import config from 'stalkers-client/config/environment'`

class ApplicationAdapter extends DS.ActiveModelAdapter
	host: config.apiHostName

	#crossdomain
	ajax: (url, method, hash) -> 
		hash = hash || {}
		hash.crossDomain = true
		return @_super(url, method, hash)

	headers: ~>
		if @session.loggedIn
			return {'Authorization': 'Bearer ' + @session.token }
		else
			return {}

`export default ApplicationAdapter`