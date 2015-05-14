attr = DS.attr

Notification = DS.Model.extend
	read: attr 'boolean'
	subject: attr()
	body: attr()
	createdAt: attr()
	createdAtFormatted: ~> moment(@createdAt).fromNow()
	notifiedObjectType: attr()
	notifiedObjectId: attr "number"

`export default Notification`