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
  let lat = locationModel.get('lat');
  let lng = locationModel.get('lng');
  return L.latLng(lat, lng);
};