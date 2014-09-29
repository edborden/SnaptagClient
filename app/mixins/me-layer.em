MeLayer = new Ember.Mixin
	init: ->
		@_super()
		@onLocationChange()

	currentLocation: ~> @controller.session.currentLocation
	content: {}

	+observer currentLocation
	onLocationChange: ->
		@content = {location: L.latLng(@currentLocation.coords.latitude, @currentLocation.coords.longitude),radius: @currentLocation.coords.accuracy}

`export default MeLayer`