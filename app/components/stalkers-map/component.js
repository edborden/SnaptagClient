import Ember from 'ember';
import LeafletMap from 'stalkers-client/components/leaflet-map';
import computed from 'ember-computed-decorators';
import { alias, equal } from 'ember-computed-decorators';

const {
  Component,
  inject: { service },
  isPresent,
  isBlank,
  isEqual
} = Ember;

export default LeafletMap.extend({

  lat: 40.7127,
  lng: -74.0059,
  zoom: 16,
  zoomControl: false,
  attributionControl: false
  
});