initializer =
	name: 'backbutton'
	initialize: ->
		document.addEventListener "backbutton", -> navigator.app.exitApp()

`export default initializer`