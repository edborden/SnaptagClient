initializer =
	name: 'cordova'
	initialize: (container,application) ->
		if cordova?	
			application.deferReadiness()
			document.addEventListener "deviceready", ->
				application.advanceReadiness()
			Ember.$.getScript 'phonegap.js'

`export default initializer`