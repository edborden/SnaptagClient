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
    // Call _super for default behavior
    this._super(controller, model);
    // Implement your custom setup after
    let myLocation = this.get('geolocation').getEmberObject();
    let boundsArray;
    if (isPresent(model)) {
      boundsArray = model.getEach('users').map(function(usersArray) {
        return usersArray.getEach('location');
      });
      // this will need to be adjusted to show multiple zones, only picking the first zone right now
      boundsArray = boundsArray.get('firstObject');
    }
    if (isPresent(boundsArray)) {
      boundsArray.pushObject(myLocation);
      controller.set('initialBounds', calculateBounds(boundsArray));
    } else {
      controller.set('center', toLeaflet(myLocation));
      controller.set('zoom', 15);
    }
  }

});