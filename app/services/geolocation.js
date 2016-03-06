import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias } from 'ember-computed-decorators';

const {
  Service,
  inject: { service },
  run: { bind },
  RSVP: { Promise },
  Object
} = Ember;

export default Service.extend({

  // attributes
  promise: null,
  resolvePromise: null,
  rejectPromise: null,
  lat: null,
  lng: null,
  accuracy: null,

  // events
  init() {
    this.setupLocation();
    this.set('promise', new Promise((resolve, reject) => {
      this.set('resolvePromise', resolve);
      this.set('rejectPromise', reject);
    }));
  },

  // helpers
  setupLocation() {
    let firstPositionSuccess = bind(this, this.firstPositionSuccess);
    let firstPositionError = bind(this, this.firstPositionError);
    let setPosition = bind(this, this.setPosition);

    navigator.geolocation.watchPosition(setPosition, this.error, { enableHighAccuracy: true });
    navigator.geolocation.getCurrentPosition(firstPositionSuccess, firstPositionError, {
      timeout: 15000,
      maximumAge: 0,
      enableHighAccuracy: true
    });
  },

  setPosition(position) {
    this.set('lat', position.coords.latitude);
    this.set('lng', position.coords.longitude);
    this.set('accuracy', position.coords.accuracy);
  },

  firstPositionSuccess(position) {
    this.setPosition(position);
    console.log('LOCATION SUCCESS');
    this.get('resolvePromise')();
  },

  firstPositionError(error) {
    this.error(error);
    this.get('rejectPromise')(error.message);
  },

  error(error) {
    console.warn(`LOCATION ERROR(${error.code}): ${error.message}`);
  },

  getObject() {
    let lat = this.get('lat');
    let lng = this.get('lng');
    return { lat, lng };
  },

  getEmberObject() {
    let lat = this.get('lat');
    let lng = this.get('lng');
    return new Object({ lat, lng });
  },

  getArray() {
    let lat = this.get('lat');
    let lng = this.get('lng');
    return [ lat, lng ];
  }

});