attr = DS.attr

Location = DS.Model.extend
	lat: attr "number"
	lon: attr "number"
	createdAt: attr()
	location: ~> L.latLng @lat, @lon
	user: DS.belongsTo 'user'
	popupContent: ~> @user.name + ", " + moment(@createdAt).fromNow()

`export default Location`