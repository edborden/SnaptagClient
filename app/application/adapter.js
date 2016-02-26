import ActiveModelAdapter from 'active-model-adapter';
import config from 'stalkers-client/config/environment';
import computed from 'ember-computed-decorators';

export default ActiveModelAdapter.extend({
  host: config.apiHostName,

  // crossdomain
  ajax(url, method, hash) {
    hash = hash || {};
    hash.crossDomain = true;
    return this._super(url, method, hash);
  },

  @computed('session.loggedIn')
  headers() {
    let session = this.get('session');
    if (session.get('loggedIn')) {
      return { 'Authorization': `Bearer ${session.get('token')}` };      
    } else {
      return {};      
    }
  }
  
});