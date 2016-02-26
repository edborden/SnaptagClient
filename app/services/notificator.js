import Ember from 'ember';

const {
  Service,
  run: { bind }
} = Ember;

export default Service.extend({

  // attributes
  regId: null,
  platform: null,

  // events
  init() {
    if (typeof cordova != 'undefined') {
      this.setup();
    } else {
      let setup = bind(this, this.setup);
      document.addEventListener('deviceready', setup);
    }
    window.onNotification = bind(this, this.onNotification);
    window.onNotificationAPN = bind(this, this.onNotificationAPN);
  },

  setup() {
    let pushNotification = window.plugins.pushNotification
    let callbackHandler = bind(this, this.callbackHandler);

    if (device.platform === 'android' || device.platform === 'Android') {
      this.set('platform', 'android');
      pushNotification.register(callbackHandler, callbackHandler, {
        "senderID": "153122295049",
        "ecb":"onNotification"
      });
    } else {
      this.set('platform', 'ios');
      pushNotification.register(callbackHandler, callbackHandler, {
        "badge": "true",
        "sound":"true",
        "alert":"true",
        "ecb":"onNotificationAPN"
      });
    }
  },

  callbackHandler(result) {
    console.log('RegistratorServiceCallback', result);
  },

  onNotificationAPN(event) {
    console.log(event);
    /*
    if (event.alert) {
      navigator.notification.alert(event.alert);
    }

    if (event.badge) {
      pushNotification.setApplicationIconBadgeNumber(successHandler, errorHandler, event.badge)
    */
  },

  onNotification(e) {
    console.log(e);

    switch (e.event) {
      case 'registered':
        this.set('regId', e.regid);
        break;

      case 'message':
        if (e.foreground) {
          console.log('app is in the foreground');
        } else {
          if (e.coldstart) {
            console.log('coldstart');
          } else {
            console.log('background notification');
          }
        }
        console.log('message:', e.payload.message);
        break;

      case 'error':
        console.log('error');
        break;
    }
  }
});