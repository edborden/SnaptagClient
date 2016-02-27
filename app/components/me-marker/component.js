import Ember from 'ember';
import MarkerLayer from 'stalkers-client/components/marker-layer';
import computed from 'ember-computed-decorators';
import { alias, equal } from 'ember-computed-decorators';

const {
  inject: { service },
  observer
} = Ember;

export default MarkerLayer.extend({

  geolocation: service(),

  @alias('geolocation.lat') lat,
  @alias('geolocation.lng') lng,

  createLayer() {
    let geolocation = this.get('geolocation');
    let lat = geolocation.get('lat');
    let lng = geolocation.get('lng');
    let accuracy = geolocation.get('accuracy');
    return L.userMarker([ lat, lng ], {
      accuracy,
      smallIcon: true,
      pulsing: true
    });
  },

  onLocationChange: observer('lat', 'lng', function() {
    let geolocation = this.get('geolocation');
    let lat = geolocation.get('lat');
    let lng = geolocation.get('lng');
    let accuracy = geolocation.get('accuracy');    
    this._layer.setLatLng([lat, lng]);
    this._layer.setAccuracy(accuracy);
  })

});