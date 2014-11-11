attr = DS.attr

Location = DS.Model.extend
	lat: attr "number"
	lng: attr "number"
	createdAt: attr()
	location: ~> L.latLng @lat, @lng
	user: DS.belongsTo 'user'
	popupContent: ~> @user.name + ", " + moment(@createdAt).fromNow()

`export default Location`