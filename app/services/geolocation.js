import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias } from 'ember-computed-decorators';

const {
  Service,
  inject: { service },
  run: { bind },
  RSVP: { Promise }
} = Ember;

export default Service.extend({

  // attributes
  currentLocationObject: null,
  promise: null,
  resolvePromise: null,

  // computed
  @alias('currentLocationObject.coords.latitude') lat,
  @alias('currentLocationObject.coords.longitude') lng,
  @alias('currentLocationObject.coords.accuracy') accuracy,

  // events
  init() {
    this.setupLocation();
    this.set('promise', new Promise((resolve) => {
      this.set('resolvePromise', resolve);
    }));
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
    this.get('resolvePromise')();
  },

  error(error) {
    console.warn('LOCATION ERROR(' + error.code + '): ' + error.message);
  }

});