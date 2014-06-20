attr = DS.attr

Location = DS.Model.extend
	lat: attr()
	lon: attr()
	created_at: attr "date"
	location: ~> return L.latLng @get('lat'), @get('lon')
	user: DS.belongsTo 'user'
	popupContent: ~> return moment(@get 'created_at').fromNow()

`export default Location`