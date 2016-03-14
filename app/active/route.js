import Ember from 'ember';
import { calculateBounds, toLeaflet } from '../utils/leaflet-helpers';
import RequiresLocation from '../mixins/requires-location';
import ChecksStatus from '../mixins/checks-status';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(RequiresLocation, ChecksStatus, {

  // services
  session: service(),
  geolocation: service(),

  // events
  model() {
    return this.get('session').get('me').get('targets').getEach('location');
  },

  setupController(controller, model) {
    // Call _super for default behavior
    this._super(controller, model);
    // Implement your custom setup after
    let myLocation = this.get('geolocation').getEmberObject();
    let boundsArray = [myLocation].pushObjects(model);
    if (boundsArray.length === 1) {
      controller.set('center', toLeaflet(myLocation));
      controller.set('zoom', 15);
    } else {
      controller.set('initialBounds', calculateBounds(boundsArray));
    }
  }

});