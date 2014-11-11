class ApplicationController extends Ember.ObjectController

	### BACK BUTTON ###

	init: ->
		@_super()
		document.addEventListener "backbutton", -> navigator.app.exitApp()

`export default ApplicationController`