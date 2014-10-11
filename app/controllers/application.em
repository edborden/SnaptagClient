class ApplicationController extends Ember.ObjectController

	## NAV HELPERS

	isPicRoute: ~> @currentRouteName is 'pic'
	isIndexRoute: ~> @currentRouteName is 'index'
	isInactivemapRoute: ~> @currentRouteName is 'inactivemap'
	isHuntUserRoute: ~> @currentRouteName is 'hunt.user'
	isHuntTargetRoute: ~> @currentRouteName is 'hunt.target'
	isMapRoute: ~> @currentRouteName is 'map'

	isBackButtonRoute: ~>
		switch @currentRouteName
			when "pic" then true
			when "hunt.expose" then true
			when "hunt.counteract" then true
			else false

	## BACK BUTTON

	currentMapRoute: ~> if @session.active then "map" else "inactivemap"

	init: ->
		@_super()
		document.addEventListener "backbutton", => 
			switch @currentRouteName
				when "index" then navigator.app.exitApp()
				when "inactivemap" then navigator.app.exitApp()
				when "map" then navigator.app.exitApp()
				when "hunt.index" then @transitionToRoute "map"
				when "me" then @transitionToRoute @currentMapRoute
				when "world" then @transitionToRoute @currentMapRoute
				else window.history.go(-1)

`export default ApplicationController`