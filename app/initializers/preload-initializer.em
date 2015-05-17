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
			if config.environment is 'production'	
				document.addEventListener "deviceready", ->
					document.addEventListener "backbutton", -> navigator.app.exitApp()
					application.advanceReadiness()
				Ember.$.getScript 'phonegap.js'
			else
				application.advanceReadiness()

`export default initializer`