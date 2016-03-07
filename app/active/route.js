import Ember from 'ember';
import { calculateBounds, toLeaflet } from 'stalkers-client/utils/leaflet-helpers';
import RequiresLocation from 'stalkers-client/mixins/requires-location';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(RequiresLocation, {

  // services
  session: service(),
  geolocation: service(),
  growler: service(),

  // events
  model() {
    return this.get('session').get('me').get('targets').getEach('location');
  },

  afterModel() {
    this.get('growler').growl(13);
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