class LoadingRoute extends Ember.Route
	beforeModel: ->
		window.plugins.spinnerDialog.show() if cordova?
		@_super()

	destroy: ->
		window.plugins.spinnerDialog.hide() if cordova?
		@_super()

`export default LoadingRoute`