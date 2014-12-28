`import { test, moduleFor } from 'ember-qunit'`

moduleFor('controller:application', "Unit - ApplicationController")

test "it exists", ->
	ok @subject()

test "transmitting", ->
	cntrl = @subject()
	cntrl.active = true
	cntrl.locationAccurate = true
	cntrl.internetConnection = true
	equal cntrl.transmitting, true
	cntrl.internetConnection = false
	equal cntrl.transmitting, false

test "locationAccurate", ->
	cntrl = @subject()
	window.cordova = "notnull"
	cntrl.currentLocation = {coords: {accuracy: 99}}
	equal cntrl.locationAccurate, true
	cntrl.currentLocation = {coords: {accuracy: 101}}
	equal cntrl.locationAccurate, false

test "setClientLoggedInStatus", ->
	window.localStorage.fbtoken = "notnull"
	cntrl = @subject()
	equal cntrl.loggedIn, true
	window.localStorage.clear()
	cntrl.setClientLoggedInStatus()
	equal cntrl.loggedIn, false
