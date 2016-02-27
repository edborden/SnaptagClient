import Ember from 'ember';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend({

  // services
  geolocation: service(),

  model() {
    let geolocation = this.get('geolocation');
    return this.get('store').query('zone', geolocation.get('object'));
  }
  
});