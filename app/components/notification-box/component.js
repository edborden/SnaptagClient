import Ember from 'ember';
import { alias } from 'ember-computed-decorators';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  // services
  session: service(),

  // attributes
  classNameBindings: [ 'read' ],
  notification: null,

  // computed
  @alias('notification.read') read,

  // events
  click() {
    if (!this.get('read')) {
      let notification = this.get('notification');
      notification.set('read', true);
      this.get('session').get('me').notifyPropertyChange('unreadNotifications');
      notification.save();
    }
  }

});