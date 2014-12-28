CenterMap = Ember.Mixin.create
	
	centerMap: (locations,context) ->
		if locations?
			locations.forEach (item,index,array) ->
				array[index] = [item] if item.typeOf is "object"
			if locations.count > 1
				markers = locations.shift()
				locations.forEach (item) -> markers.concat(item)
			else
				markers = locations
			bounds = L.latLngBounds(markers)
			context.fitBounds(bounds,{ padding: [75, 75] })
		else
			return

`export default CenterMap`