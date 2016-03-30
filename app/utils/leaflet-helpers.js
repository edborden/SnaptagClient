import { distance } from 'snaptag-client/utils/geo-helpers';
/* global L */

export function calculateBoundsWithMinimum(locationsArray) {
  let bounds = calculateBounds(locationsArray);
  return padBounds(bounds);
}

export function calculateBounds(locationsArray) {
  let bounds = L.latLngBounds(toLeafletArray(locationsArray));
  return bounds;
};

export function padBounds(bounds) {
  let width = widthOfBounds(bounds);
  let padding = 2500 / width;
  if (padding > 1) {
    return bounds.pad(padding);
  } else {
    return bounds;    
  }
};

export function widthOfBounds(bounds) {
  return leafletDistance(bounds.getNorthEast(), bounds.getSouthWest());
};

export function leafletDistance(leaf1, leaf2) {
  return distance(leaf1.lat, leaf1.lng, leaf2.lat, leaf2.lng);
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