import config from '../config/environment';
import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias } from 'ember-computed-decorators';

const {
  Service,
  inject: { service }
} = Ember;

export default Service.extend({

  // services
  session: service(),

  // computed
  @alias('session.me') me,

  @computed('me')
  structuredMe() {
    if (this.get('session').get('isAuthenticated')) {
      return this.get('me').getProperties('id', 'name', 'email');
    } else {
      return null;
    }
  },

  @computed
  client() {
    return new Keen({
      projectId: config.keenProjectId,
      writeKey: config.keenWriteKey,
      protocol: 'auto',
      host: 'api.keen.io/3.0',
      requestType: 'jsonp'
    });
  },

  @computed
  visitId() {
    return (Math.random()*9e6).toString(36);
  },

  addEvent(eventName, context = null) {
    return this.get('client').addEvent(eventName, {
      user: this.get('structuredMe'),
      visitId: this.get('visitId'),
      context
    });
  }

});