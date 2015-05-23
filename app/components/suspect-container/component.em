`import Rotatable from 'stalkers-client/mixins/rotatable'`

class SuspectContainerComponent extends Ember.Component with Rotatable
	session: Ember.inject.service()
	classNameBindings: ["target"]

	target: ~> @suspect.isTarget

	activeSuspect: null
	active: ~> @activeSuspect is @suspect

	totalCount: ~> @session.me.suspects.length

	panelDim: ~> 78*@vw/2
	circleDim: ~> 19*@vw/2

	action: 'suspectClicked'

	click: ->
		@sendAction 'action',@suspect

`export default SuspectContainerComponent`