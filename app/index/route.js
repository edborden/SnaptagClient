import Ember from 'ember';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend({

  // services
  updater: service(),
  session: service(),
  geolocation: service(),

  beforeModel() {
    let shouldUpdateApp = this.get('updater').get('updateApp');
    let session = this.get('session');

    if (shouldUpdateApp) {
      this.replaceWith('update');     
    } else {
      if (session.get('active')) {
        console.log('transitionTo map');
        this.replaceWith('map');
      } else {
        if (session.get('inactive') || session.get('queue')) {
          console.log('transitionTo inactivemap');
          this.replaceWith('inactivemap');
        }
      }
    }
  },

  model() {
    let geolocation = this.get('geolocation');
    console.log('geo success?', geolocation.get('success'));

    if (geolocation.get('success')) {
      return this.get('store').find('zone', geolocation.get('object'));
    } else {
      return [];
    }
  }
});