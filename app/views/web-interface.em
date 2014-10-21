class WebInterfaceView extends Ember.View

	width: ~> @controller.width
	elWidth: ~> @width * 0.95

	contentSection: 1
	activeSuspect: null
	showWeb: false
	templateName: 'web/top'

	panelWidth: ~> @elWidth - 60
	halfPanelWidth: ~> @panelWidth * -0.5
	circleWidth: ~> @panelWidth * 0.5
	halfCircleWidth: ~> @circleWidth * -0.5

	panelStyle: ~> "width:#{@panelWidth}px;height:#{@panelWidth}px;margin-left:#{@halfPanelWidth}px;margin-top:#{@halfPanelWidth}px"
	circleStyle: ~> "width:#{@circleWidth}px;height:#{@circleWidth}px;margin-left:#{@halfCircleWidth}px;margin-top:#{@halfCircleWidth}px"

	actions:
		toggle: -> @toggleProperty 'showWeb'
		middle: -> @contentSection = switch @contentSection
			when 1 then 2
			when 2 then 1
		suspect: (suspect) ->
			if @activeSuspect is suspect
				@activeSuspect = null
				@contentSection = 1 unless @contentSection is 1
			else
				@activeSuspect = suspect
				@contentSection = 1 unless @contentSection is 1

`export default WebInterfaceView`