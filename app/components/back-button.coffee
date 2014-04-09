BackButtonComponent = Ember.Component.extend(
	actions:
		back: ->
			window.history.go(-1)
)

`export default BackButtonComponent`