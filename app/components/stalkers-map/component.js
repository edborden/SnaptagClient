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

  geolocation: service(),

  lat: null,
  lng: null,
  zoom: 16,
  zoomControl: false,
  attributionControl: false,

  init() {
    let geolocation = this.get('geolocation');
    let lat = geolocation.get('lat');
    let lng = geolocation.get('lng');
    this.set('lat', lat);
    this.set('lng', lng);
    this._super();
  }
  
});