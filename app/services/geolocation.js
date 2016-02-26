import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias } from 'ember-computed-decorators';

const {
  Service,
  inject: { service },
  run: { bind }
} = Ember;

export default Service.extend({

  // attributes
  success: false,
  currentLocationObject: null,

  // computed
  @alias('currentLocationObject.coords.latitude') lat,
  @alias('currentLocationObject.coords.longitude') lng,
  @alias('currentLocationObject.coords.accuracy') accuracy,

  @computed('lat', 'lng')
  location() {
    let lat = this.get('lat');
    let lng = this.get('lng');
    return L.latLng(lat, lng);
  },

  @computed('lat', 'lng')
  object() {
    let lat = this.get('lat');
    let lng = this.get('lng');
    return { lat, lng };
  },

  @computed('lat', 'lng')
  array() {
    let lat = this.get('lat');
    let lng = this.get('lng');
    return [ lat, lng ];
  },

  // events
  init() {
    this.setupLocation();
  },

  // helpers
  setupLocation() {
    let firstPositionSuccess = bind(this, this.firstPositionSuccess);
    let setPosition = bind(this, this.setPosition);

    navigator.geolocation.watchPosition(setPosition, this.error, { enableHighAccuracy: true });
    navigator.geolocation.getCurrentPosition(firstPositionSuccess, this.error, {
      timeout: 15000,
      maximumAge: 0,
      enableHighAccuracy: true
    });
  },

  setPosition(position) {
    this.set('currentLocationObject', position);
  },

  firstPositionSuccess(position) {
    this.setPosition(position);
    console.log('LOCATION SUCCESS');
    this.set('success', true);
  },

  error(error) {
    console.warn('LOCATION ERROR(' + error.code + '): ' + error.message);
  }

});