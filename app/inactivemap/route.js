import Ember from 'ember';
import { calculateBounds } from 'stalkers-client/utils/leaflet-helpers';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend({

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
    controller.set('initialBounds', calculateBounds(boundsArray));
  }

});