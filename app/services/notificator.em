class NotificatorService extends Ember.Service

	store: Ember.inject.service()
	session: Ember.inject.service()

	handle: (data) ->
		data = Ember.$.parseJSON(data) if typeof data is "string"
		@store.pushPayload data
		notification = @store.getById 'notification',data.notification.id
		@session.me.notifications.unshiftObject notification
		@session.me.notifyPropertyChange 'unreadNotifications'
		return notification.subject	

`export default NotificatorService`