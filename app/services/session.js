import Ember from 'ember';
import { alias, notEmpty, equal } from 'ember-computed-decorators';

const {
  Service,
  inject: { service },
  RSVP: { Promise },
  run: { bind }
} = Ember;

export default Service.extend({

  // services
  store: service(),
  notificator: service(),

  // attributes
  model: null,

  // computed
  @alias('model.user') me,
  @alias('model.token') token,
  @notEmpty('model') loggedIn,
  @alias('me.status') status,
  @equal('status', 'active') active,
  @equal('status', 'queue') queue,
  @equal('status', 'inactive') inactive,
  
  // helpers
  refresh() {
    this.openWithToken(this.get('token'));
  },

  openWithToken(token) {
    let store = this.get('store');

    return new Promise((resolve, reject) => {
      store.query('session', { token })
      .then((response) => {
        this.openWithSession(response.get('firstObject'));
        resolve();
      }, (error) => { 
        localStorage.clear();
        reject(error);
      });
    });
  },

  openWithSession(session) {
    this.set('model', session);
    localStorage.stalkersToken = this.get('token');
  },

  openWithUser(user) {
    let notificator = this.get('notificator');
    let openWithSession = bind(this, this.openWithSession);
    let store = this.get('store');
    return new Promise(function(resolve, reject) {
      store.createRecord('session', {
        token: user,
        regId: notificator.get('regId'),
        platform: notificator.get('platform')
      }).save()
      .then(function(response) {
        openWithSession(response);
        resolve('Logged in successfully');
      }, function(error) { 
        console.log('openWithUser error', error);
        reject(error.responseJSON);
      });
    });
  },

  close() {
    localStorage.clear();
    this.set('model', null);
  }

});