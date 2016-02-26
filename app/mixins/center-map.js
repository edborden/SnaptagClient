import Ember from 'ember';

const {
  Mixin,
  isPresent
} = Ember;

export default Mixin.create({
	
	centerMap(locations,context) {
		if (isPresent(locations)) {
			locations.forEach(function(item,index,array) {
				if (item.typeOf === 'object') {
					array[index] = [item];
				}
			});
			if (locations.count > 1) {
				let markers = locations.shift();
				locations.forEach(function(item) {
					markers.concat(item);
				});
			}	else {
				let markers = locations;
			}
			let bounds = L.latLngBounds(markers);
			context.fitBounds(bounds, { padding: [75, 75] });
		} else {
			return;
		}
	}
});