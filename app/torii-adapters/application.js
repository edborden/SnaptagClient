import Ember from 'ember';
import { alias, notEmpty, equal } from 'ember-computed-decorators';

const {
  Object,
  inject: { service },
  RSVP,
  isPresent
} = Ember;

export default Object.extend({

  // services
  store: service(),
  notificator: service(),
  growler: service(),

  open(auth) {
    let notificator = this.get('notificator');
    let store = this.get('store');
    let { authorizationToken: { token } } = auth;

    return store.createRecord('session', {
      token,
      regId: notificator.get('regId'),
      platform: notificator.get('platform')
    }).save()
    .then((response) => {
      localStorage.stalkersToken = response.get('token');
      return {
        currentSession: response,
        me: response.get('user')
      };
    });
  },

  fetch() {
    let token = localStorage.stalkersToken;

    if (isPresent(token)) {
      let store = this.get('store');

      return store.query('session', { token })
      .then((response) => {
        let session = response.get('firstObject');
        return {
          currentSession: session,
          me: session.get('user')
        };
      }, (error) => {
        localStorage.clear();
        reject(error);
      });
    } else {
      return RSVP.reject();
    }
  },

  close() {
    localStorage.clear();
    return RSVP.resolve();
  }

});