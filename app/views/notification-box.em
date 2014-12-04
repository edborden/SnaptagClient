class NotificationBoxView extends Ember.View
	templateName: 'notification'
	classNames: ['item']
	classNameBindings: ['context.read:read']

	click: -> 
		unless @context.read
			@context.read = true
			@controller.session.me.notifyPropertyChange 'unreadNotifications'
			@context.save()


`export default NotificationBoxView`