import Ember from 'ember';
import config from '../config/environment';
import computed from 'ember-computed-decorators';

const {
  inject: { service },
  Mixin
} = Ember;

export default Mixin.create({

  // services
  session: service(),

  // attributes
  host: config.apiHostName,

  @computed('session.isAuthenticated')
  headers() {
    let session = this.get('session');
    if (session.get('isAuthenticated')) {
      return { 'Authorization': `Bearer ${session.get('currentSession').get('token')}` };
    } else {
      return {};
    }
  }

});