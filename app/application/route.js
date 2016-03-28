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
  modaler: service(),

  // computed
  @alias('session.me') me,

  // events
  afterModel() {
    this.get('realtime').statusChanged();
  },

  // actions
  actions: {
    closer() {
      this.get('modaler').closer();
    },
    setModal(name, type, model) {
      this.get('modaler').setModal(name, type, model);
    },

    closeModal() {
      this.get('modaler').closeModal();
    },

    error(error) {
      console.log(error);
      this.get('geolocation').init();
      this.replaceWith('error', error);
    },

    logout() {
      this.send('closeModal');
      this.get('session').close();
      this.replaceWith('search');
      this.get('growler').growl(1);
      this.get('keen').addEvent('logout');
    },

    login() {
      this.login();
    },

    join() {
      this.join();
    },

    unjoin() {
      this.get('keen').addEvent('unjoin');
      let me = this.get('session').get('me');
      this.get('ajax').getServer('actions/unjoin');
      me.set('status', 'inactive');
      me.set('activationqueue', null);
      this.get('growler').growl(7);
      this.replaceWith('inactive');
    },

    loginJoin() {
      this.get('keen').addEvent('loginJoin');
      this.login().then(() => {
        if (this.get('me').get('inactive')) {
          this.join();
        }
      });
    },

    found(target, imageId) {
      // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
      this.send('closeModal');
      this.get('keen').addEvent('found', target.getProperties('id', 'name', 'email'));
      this.get('loader').in();
      this.get('ajax').getServer('actions/found_target', {
        target_id: target.get('id'),
        image_id: imageId
      });
    },

    expose(suspect) {
      // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
      this.send('closeModal');
      this.get('keen').addEvent('expose', suspect.getProperties('id', 'name', 'email'));
      this.get('loader').in();
      this.get('ajax').getServer('actions/expose', { stalker_id: suspect.get('id') });
    },

    accessDenied() {
      this.replaceWith('index');
    }
  },

  // helpers
  login() {
    let loader = this.get('loader');
    let keen = this.get('keen');
    let growler = this.get('growler');
    keen.addEvent('loginInitiated');
    loader.in();
    return this.facebookLogin()
    .then(
      () => {
        loader.out();
        growler.growl(2);
        keen.addEvent('loginSuccess');
        let status = this.get('me').get('status');
        this.replaceWith(status);
      },
      function(error) {
        loader.out();
        console.log('loginFailure', error);
        growler.growl('Login failure');
        keen.addEvent('loginFailure', error);
      }
    );
  },

  join() {
    this.get('keen').addEvent('joinInitiated');
    this.get('loader').in();
    this.get('ajax').getServer('actions/join', { location: this.get('geolocation').getObject() });
  },

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