import Ember from 'ember';
import config from '../config/environment';
import { alias } from 'ember-computed-decorators';

const {
  inject: { service },
  RSVP: { Promise },
  Route,
  isPresent
} = Ember;

export default Route.extend({

  // services
  growler: service(),
  executive: service(),
  session: service(),
  loader: service(),
  geolocation: service(),
  realtime: service(),
  ajax: service(),
  keen: service(),

  // computed
  @alias('session.me') me,

  // events
  afterModel() {
    this.get('realtime').statusChanged();
  },

  // actions
  actions: {
    logout() {
      this.get('session').close();
      this.transitionTo('index');
      this.get('growler').growl(1);
    },

    login() {
      let loader = this.get('loader');

      loader.in();
      this.facebookLogin()
      .then(() => {
        loader.out();
        this.get('growler').growl(2);
        let status = this.get('me').get('status');
        this.transitionTo(status);
      });
    },

    join() {
      this.get('loader').in();
      this.get('ajax').getServer('hunts/join', { location: this.get('geolocation').getObject() });
    },

    unjoin() {
      let me = this.get('session').get('me');
      this.get('ajax').getServer('hunts/unjoin');
      me.set('status', 'inactive');
      me.set('activationqueue', null);
      this.get('growler').growl(7);
      this.transitionTo('inactive');
    },

    found(target, imageId) {
      // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
      this.get('keen').addEvent('found', target.getProperties('id', 'name', 'email'));
      this.get('loader').in();
      this.get('ajax').getServer('hunts/found_target', {
        target_id: target.get('id'),
        image_id: imageId
      });
    },
    
    expose(suspect) {
      // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
      this.get('keen').addEvent('expose', suspect.getProperties('id', 'name', 'email'));
      this.get('loader').in();
      this.get('ajax').getServer('hunts/expose', { stalker_id: suspect.get('id') });
    },

    accessDenied() {
      this.transitionTo('index');
    }
  },

  // helpers
  facebookLogin() {
    let session = this.get('session');
    let provider;
    // if (config.environment === 'production') {
    //  provider = 'facebook-phonegap';
    // } else {
    provider = 'facebook-token';
    // }
    return session.open(provider);
  }

});