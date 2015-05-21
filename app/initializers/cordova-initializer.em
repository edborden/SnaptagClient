`import config from 'stalkers-client/config/environment'`

initializer =
	name: 'cordova'
	after: 'services'
	initialize: ->
			
		if config.environment is 'production'	
			document.addEventListener "deviceready", ->
				console.log 'deviceready!'
				document.addEventListener "backbutton", -> navigator.app.exitApp()
			console.log 'Get phonegap now'
			Ember.$.getScript 'phonegap.js'

`export default initializer`