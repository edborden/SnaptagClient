class NotificationBoxComponent extends Ember.Component

	session:Ember.inject.service()

	classNames: ['item']
	classNameBindings: ['notification.read:read']

	click: -> 
		unless @notification.read
			@notification.read = true
			@session.me.notifyPropertyChange 'unreadNotifications'
			@notification.save()

`export default NotificationBoxComponent`