import Ember from 'ember';
import ServerTalk from 'stalkers-client/mixins/server-talk';
import config from 'stalkers-client/config/environment';
import { alias } from 'ember-computed-decorators';

const {
  inject: { service },
  RSVP: { Promise },
  Route,
  isPresent
} = Ember;

export default Route.extend(ServerTalk, {

  // services
  growler: service(),
  executive: service(),
  updater: service(),
  session: service(),
  loader: service(),
  geolocation: service(),
  realtime: service(),

  // computed
  @alias('session.currentUser') me,

  // events
  afterModel() {
    this.get('realtime').statusChanged();
    return this.get('geolocation').get('promise');
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
      let growler = this.get('growler');

      loader.in();
      this.facebookLogin()
      .then(() => {
        let me = this.get('me');
        if (me.get('active')) {
          loader.out();
          this.transitionTo('map');
          growler.growl(2);
        } else {
          loader.out();
          this.transitionTo('inactivemap');
          if (me.get('inactive')) {
            growler.growl(3);
          } else {
            growler.growl(4);
          }
        }
      });
    },

    join() {
      this.get('loader').in();
      this.getServer('hunts/join', { location: this.get('geolocation').getObject() });
    },
            
    unjoin() {
      let me = this.get('session').get('me');
      this.getServer('hunts/unjoin');
      me.set('status' ,'inactive');
      me.set('activationqueue', null);
      this.get('growler').growl(7);
    },

    found(target) {
      this.get('loader').in();
      this.getServer('hunts/found_target', { target_id: target.get('id') });
    },

    expose(suspect) {
      this.get('loader').in();
      this.getServer('hunts/expose', { stalker_id: suspect.get('id') });
    },

    accessDenied() {
      this.transitionTo('index');
    }
  },

  // helpers
  facebookLogin() {
    let session = this.get('session');
    let provider;
    if (config.environment === 'production') {
      provider = 'facebook-phonegap';
    } else {
      provider = 'facebook-token';
    }
    return session.open(provider)
  }

});