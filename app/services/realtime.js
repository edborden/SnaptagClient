import Ember from 'ember';
import { alias, notEmpty, equal } from 'ember-computed-decorators';

const {
  Service,
  inject: { service },
  run: { bind },
  observer,
  isPresent
} = Ember;

export default Service.extend({

  // services
  store: service(),
  session: service(),
  growler: service(),
  executive: service(),

  // attributes
  pusher: null,
  // Set in intializer to MapController
  map: null,

  // computed
  @alias('session.currentUser') me,

  //events
  init() {
    this._super();
    this.get('me');
  },

  statusChanged: observer('me.status', function() {
    console.log('status changed');
    if (isPresent(this.get('pusher'))) {
      this.disconnect();
    }
    if (this.get('session').get('loggedIn')) {
      console.log(this.get('me').get('status'));
      this.setPusher();
      this.subscribeToNotifications();
      switch (this.get('me').get('status')) {
        case 'queue':
          this.setPusherQueue();
          break;
        case 'active':
          this.setPusherActive();
          break;
        case 'inactive':
          this.setPusherInactive();
          break;
      }
    }   
  }),
    
  // helpers    
  disconnect() {
    this.get('pusher').disconnect();
  },

  subscribeToNotifications() {
    let channel = this.get('pusher').subscribe(`user${this.get('me').get('id')}`);

    channel.bind('notification', (data) => {
      console.log('notification push', data);
      this.handleNotification(data);
    });
  },

  setPusher() {
    this.set('pusher', new Pusher('0750760773b8ed5ae1dc'));
  },

  setPusherInactive() {
    console.log('setPusherInactive');
  },

  setPusherActive() {
    console.log('setPusherActive');
    let me = this.get('me');
    let channel = this.get('pusher').subscribe(`user${me.get('id')}`);

    let messages = [ 'New target', 'New suspect', 'Suspect removed' ];
    this.bindMessagesToChannel(messages, channel);

    me.get('targets').forEach((target) => {
      this.watchTarget(target);
    });
  },    

  setPusherQueue() {
    console.log('setPusherQueue');
    let me = this.get('me');
    let pusher = this.get('pusher');

    let channel = pusher.subscribe(`user${me.get('id')}`);
    let messages = [ 'You have entered the game' ];
    this.bindMessagesToChannel(messages, channel);

    channel = pusher.subscribe('activationqueue' + me.get('activationqueue').get('id'));
    messages = [ 'Add user to activationqueue', 'Remove user from activationqueue' ];
    this.bindMessagesToChannel(messages, channel);
  },

  watchTarget(target) {
    let channel = this.get('pusher').subscribe('user' + target.get('id'));
    let messages = [ 'New target location' ];
    this.bindMessagesToChannel(messages, channel);
  },

  bindMessagesToChannel(messages, channel) {
    let executive = this.get('executive');
    messages.forEach(function(message) {
      channel.bind(message, function(data) { 
        console.log('Message received ', message);
        executive.action(message, data);
      });
    });
  },

  handleNotification(data) {
    let me = this.get('me');
    let store = this.get('store');

    if (typeof data === 'string') {
      data = Ember.$.parseJSON(data);
    }
    store.pushPayload(data);
    let notification = store.peekRecord('notification', data.notification.id);
    me.get('notifications').unshiftObject(notification);
    me.notifyPropertyChange('unreadNotifications');
    this.get('executive').action(notification.get('subject'), notification);
  }
});