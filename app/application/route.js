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

  // computed
  @alias('session.me') me,

  // events
  beforeModel() {
    let token = localStorage.stalkersToken;
    let session = this.get('session');
    let growler = this.get('growler');
    let updater = this.get('updater');

    return new Promise(function(resolve) {
      updater.checkUpdate()
      .then((result) => {
        if (result === false && isPresent(token)) {
          session.openWithToken(token)
          .then(function() {
            resolve();
            growler.growl(13);
          });
        } else {
          resolve();
          growler.growl(13);
        }
      });
    });
  },

  // actions
  actions: {
    logout() {
      this.get('session').close();
      this.transitionTo('index');
      this.get('growler').growl(1);
    },

    login() {
      let session = this.get('session');
      let loader = this.get('loader');
      let growler = this.get('growler');

      loader.in();
      this.facebookLogin()
      .then((token) => {
        session.openWithUser(token)
        .then(() => {
          if (session.get('active')) {
            loader.out();
            this.transitionTo('map');
            growler.growl(2);
          } else {
            loader.out();
            this.transitionTo('inactivemap');
            if (session.get('inactive')) {
              growler.growl(3);
            } else {
              growler.growl(4);
            }
          }
        });
      });      
    },

    join() {
      this.get('loader').in();
      this.getServer('hunts/join', { location: this.get('geolocation').get('object') });
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
    }
  },

  // helpers
  facebookLogin() {
    let torii = this.get('torii');
    return new Promise(function(resolve) {
      if (config.environment === 'production') {
        facebookConnectPlugin.login(['email'], function(response) {
          console.log('Facebook connect success', response);
          resolve(response.authResponse.accessToken);
        });
      } else {
        torii.open('facebook-token')
        .then(function(authorization) {
          console.log('torii success', authorization);
          resolve(authorization.authorizationToken.token);         
        });
      }
    });
  }
});