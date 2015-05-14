`import config from 'stalkers-client/config/environment'`

initializer =
	name: 'preload'
	after: 'services'
	initialize: (container,application) ->
		application.deferReadiness()

		## setup geolocation
		geolocation = container.lookup 'service:geolocation'
		geolocation.setupLocation().then =>

		## setup Phonegap
			if config.environment is 'phonegap'	
				document.addEventListener "deviceready", ->
					document.addEventListener "backbutton", -> navigator.app.exitApp()
					application.advanceReadiness()
				console.log 'pre phonegap'
				Ember.$.getScript 'phonegap.js'
				console.log 'post phonegap'
				window.application = application
			else
				application.advanceReadiness()

`export default initializer`