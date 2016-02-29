/* global L */

export function calculateBounds(locationsArray) {
  return L.latLngBounds(toLeafletArray(locationsArray));
};

export function toLeafletArray(locationsArray) {
  return locationsArray.map(function(location) {
    return toLeaflet(location);
  });
};

export function toLeaflet(locationModel) {
  const lat = locationModel.get('lat');
  const lng = locationModel.get('lng');
  return L.latLng(lat, lng);  
};