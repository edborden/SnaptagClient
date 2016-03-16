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
  growler: service(),

  open(auth) {
    let store = this.get('store');
    let { authorizationToken: { token } } = auth;

    return store.createRecord('session', {
      token
    }).save()
    .then((response) => {
      localStorage.snaptagToken = response.get('token');
      return {
        currentSession: response,
        me: response.get('user')
      };
    });
  },

  fetch() {
    let token = localStorage.snaptagToken;

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
        localStorage.snaptagToken = null;
        reject(error);
      });
    } else {
      return RSVP.reject();
    }
  },

  close() {
    localStorage.snaptagToken = null;
    return RSVP.resolve();
  }

});