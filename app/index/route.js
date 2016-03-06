import Ember from 'ember';
import { alias } from 'ember-computed-decorators';
import { calculateBounds, toLeaflet } from 'stalkers-client/utils/leaflet-helpers';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend({

  // services
  updater: service(),
  session: service(),
  geolocation: service(),

  // computed
  @alias('session.me') me,

  beforeModel() {
    let shouldUpdateApp = this.get('updater').get('updateApp');
    let me = this.get('me');

    if (shouldUpdateApp) {
      this.replaceWith('update');
    } else {
      let isAuthenticated = this.get('session').get('isAuthenticated');
      if (isAuthenticated) {
        if (me.get('active')) {
          console.log('transitionTo map');
          this.replaceWith('map');
        } else {
          if (me.get('inactive') || me.get('queue')) {
            console.log('transitionTo inactivemap');
            this.replaceWith('inactivemap');
          }
        }
      }
    }
  },

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