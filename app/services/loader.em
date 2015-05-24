class LoaderService extends Ember.Service

	in: ->
		if cordova?
			window.plugins.spinnerDialog.show(null, null, true)
		else
			return

	out: ->
		if cordova?
			window.plugins.spinnerDialog.hide()
		else
			return		

`export default LoaderService`