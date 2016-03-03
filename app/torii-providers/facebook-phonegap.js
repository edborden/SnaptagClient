import Ember from 'ember';
import { configurable } from 'torii/configuration';
/* global facebookConnectPlugin */

const {
  Object,
  RSVP: { Promise }
} = Ember;

export default Object.extend({

  scope: configurable('scope', 'email'),

  open(){
    let scope = this.get('scope');
    return new Promise(function(resolve, reject) {
      facebookConnectPlugin.login(scope, function(response) {
        console.log('Facebook connect success', response);
        resolve({ 
          authorizationToken: response.authResponse.accessToken
        });
      });
    });
  }
});