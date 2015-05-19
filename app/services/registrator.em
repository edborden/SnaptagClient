class RegistratorService extends Ember.Service

	init: ->
		console.log "RegistratorService init"
		document.addEventListener "deviceready", =>
			pushNotification = window.plugins.pushNotification
			if device.platform is 'android' or device.platform is 'Android'
				pushNotification.register @successHandler,@errorHandler,{"senderID":"153122295049","ecb":"onNotification"}
			else
				pushNotification.register @tokenHandler,@errorHandler,{"badge":"true","sound":"true","alert":"true","ecb":"onNotificationAPN"}

	successHandler: ( (result) ->
		console.log 'RegistratorService'
		console.log @
		console.log result
	).bind @

	tokenHandler: ( (result) ->
		console.log 'RegistratorService'
		console.log @
		console.log result		
	).bind @

	errorHandler: ( (error) ->
		console.log @
		console.log error		
	).bind @

	onNotificationAPN: (event) ->
		console.log event
		if event.alert
			navigator.notification.alert(event.alert)

		if event.badge 
			pushNotification.setApplicationIconBadgeNumber(successHandler, errorHandler, event.badge)

	onNotification: (e) ->
		console.log e

		switch e.event
			when 'registered' then console.log e.regid

			when 'message'
				if e.foreground
					console.log 'app is in the foreground'
				else

					if e.coldstart
						console.log 'coldstart'
					else
						console.log 'background notification'

				console.log 'message:',e.payload.message
				console.log e.payload.timeStamp

			when 'error'
				console.log 'error',e

`export default RegistratorService`