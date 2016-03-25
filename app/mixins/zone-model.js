import Ember from 'ember';
import { calculateBounds, toLeaflet } from 'snaptag-client/utils/leaflet-helpers';

const {
  Mixin,
  inject: { service },
  isPresent
} = Ember;

export default Mixin.create({

  // services
  geolocation: service(),

  model() {
    let geolocation = this.get('geolocation');
    let object = geolocation.getObject();
    return this.get('store').query('zone', object);
  },

  setupController(controller, model) {
    this._super(controller, model);
    let boundsArray;
    if (isPresent(model)) {
      // this will need to be adjusted to show multiple zones, only picking the first zone right now
      controller.set('center', toLeaflet(model.get('firstObject')));
      controller.set('zoom', 12);
    } else {
      // need to handle no model
      let defaultNYC = new Ember.Object({
        lat: 40.7127,
        lng: -74.0058
      });
      controller.set('center', toLeaflet(defaultNYC));
      controller.set('zoom', 12);
    }
  }

});