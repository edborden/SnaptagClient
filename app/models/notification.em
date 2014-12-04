attr = DS.attr

Notification = DS.Model.extend
	read: attr 'boolean'
	subject: attr()
	body: attr()
	# no clue why I have to do this to get body to render in templates, something with mailboxer..
	cacheBody: ~> @body
	createdAt: attr()
	createdAtFormatted: ~> moment(@createdAt).fromNow()
	notifiedObjectType: attr()
	notifiedObjectId: attr "number"

`export default Notification`