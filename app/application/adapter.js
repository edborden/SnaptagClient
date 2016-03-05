import Ember from 'ember';
import ActiveModelAdapter from 'active-model-adapter';
import config from 'stalkers-client/config/environment';
import computed from 'ember-computed-decorators';

const {
  inject: { service }
} = Ember;

export default ActiveModelAdapter.extend({

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
  },

  // crossdomain
  ajax(url, method, hash) {
    hash = hash || {};
    hash.crossDomain = true;
    return this._super(url, method, hash);
  }

});