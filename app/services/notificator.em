class NotificatorService extends Ember.Service

	regId: null
	platform: null

	init: ->
		if cordova?
			@setup()
		else
			document.addEventListener "deviceready", => @setup()

		window.onNotification = Ember.run.bind @,@onNotification
		window.onNotificationAPN = Ember.run.bind @,@onNotificationAPN

	setup: ->
		pushNotification = window.plugins.pushNotification

		if device.platform is 'android' or device.platform is 'Android'
			@platform = 'android'
			pushNotification.register null,null,{"senderID":"153122295049","ecb":"onNotification"}
		else
			@platform = 'ios'
			pushNotification.register null,null,{"badge":"true","sound":"true","alert":"true","ecb":"onNotificationAPN"}			

	onNotificationAPN: (event) ->
		console.log event
		if event.alert
			navigator.notification.alert(event.alert)

		if event.badge 
			pushNotification.setApplicationIconBadgeNumber(successHandler, errorHandler, event.badge)

	onNotification: (e) ->
		console.log e

		switch e.event
			when 'registered' then @regId = e.regid

			when 'message'
				if e.foreground
					console.log 'app is in the foreground'
				else

					if e.coldstart
						console.log 'coldstart'
					else
						console.log 'background notification'

				console.log 'message:',e.payload.message

			when 'error'
				console.log 'error',e

`export default NotificatorService`