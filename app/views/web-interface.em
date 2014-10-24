class WebInterfaceView extends Ember.View

	contentSection: 1
	activeSuspect: null
	showWeb: false
	templateName: 'web/top'

	contentSectionOne: ~> @contentSection is 1

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