import Ember from 'ember';
import { calculateBounds } from 'stalkers-client/utils/leaflet-helpers';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend({

  session: service(),
  geolocation: service(),

  model() {
    return this.get('session').get('currentUser').get('targets').getEach('location');
  },

  setupController(controller, model) {
    // Call _super for default behavior
    this._super(controller, model);
    // Implement your custom setup after
    const myLocation = this.get('geolocation').getEmberObject();
    const boundsArray = [myLocation].pushObjects(model);
    controller.set('initialBounds', calculateBounds(boundsArray));
  }

});