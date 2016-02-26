import Ember from 'ember';
import config from 'stalkers-client/config/environment';
import computed from 'ember-computed-decorators';

const {
  Mixin
} = Ember;

export default Mixin.create({
  
  getServer(url, data, dataType) {
    data = data || {};
    dataType = dataType || 'text';

    let headers = this.get('headers');

    return new Ember.RSVP.Promise(function(resolve) {
      Ember.$.ajax({
        data,
        url: config.apiHostName + '/' + url + '.json',
        success(response) { 
          resolve(response);
        },
        dataType,
        headers,
        crossDomain: true
      });
    });
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