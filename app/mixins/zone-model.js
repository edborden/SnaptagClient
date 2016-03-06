import Ember from 'ember';
import { calculateBounds, toLeaflet } from 'stalkers-client/utils/leaflet-helpers';

const {
  Mixin,
  inject: { service }
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
    let boundsArray = model.getEach('users').map(function(usersArray) {
      return usersArray.getEach('location');
    });
    boundsArray = boundsArray.get('firstObject');
    boundsArray.pushObject(myLocation);
    if (boundsArray.length === 1) {
      controller.set('center', toLeaflet(myLocation));
      controller.set('zoom', 15);
    } else {
      controller.set('initialBounds', calculateBounds(boundsArray));
    }
  }

});