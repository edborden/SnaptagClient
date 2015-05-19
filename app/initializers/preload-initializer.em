`import config from 'stalkers-client/config/environment'`

initializer =
	name: 'preload'
	after: 'services'
	initialize: (container,application) ->
		application.deferReadiness()
		window.app = application

		## setup geolocation
		console.log 'before geolocation setup'
		geolocation = container.lookup 'service:geolocation'
		geolocation.setupLocation().then =>
			console.log 'after gelocation setup'
		## setup Phonegap
			if config.environment is 'production'	
				document.addEventListener "deviceready", ->
					console.log 'deviceready!'
					document.addEventListener "backbutton", -> navigator.app.exitApp()
					application.advanceReadiness()
				console.log 'Get phonegap now'
				Ember.$.getScript 'phonegap.js'
			else
				application.advanceReadiness()

`export default initializer`