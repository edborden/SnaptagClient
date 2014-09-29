class ApplicationController extends Ember.ObjectController

	## NAV HELPERS

	isPicRoute: Ember.computed.equal 'currentRouteName', 'pic'
	isIndexRoute: Ember.computed.equal 'currentRouteName', 'index'
	isInactivemapRoute: Ember.computed.equal 'currentRouteName', 'inactivemap'
	isHuntUserRoute: Ember.computed.equal 'currentRouteName', 'hunt.user'
	isHuntTargetRoute: Ember.computed.equal 'currentRouteName', 'hunt.target'
	isMapRoute: Ember.computed.equal 'currentRouteName', 'map'

	isBackButtonRoute: ~>
		switch @currentRouteName
			when "pic" then return true
			when "hunt.expose" then return true
			when "hunt.counteract" then return true
			else return false

	## BACK BUTTON

	currentMapRoute: ~>
		if @session.active then return "map" else return "inactivemap"

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