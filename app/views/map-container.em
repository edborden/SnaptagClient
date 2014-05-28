`import Target1MapView from 'appkit/views/target1-map'`

class MapContainerView extends Ember.ContainerView
	classNames: ['map-container']

	+observer controller.activeTarget
	onActiveTargetChange: ->
		@removeObject @childViews[0]
		@pushObject @controller.activeTarget
		@rerender()

	init: ->
		@_super()
		@pushObject(new Target1MapView(controller: @controller))

`export default MapContainerView`