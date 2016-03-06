import Ember from 'ember';
const {
  Service
} = Ember;

export default Service.extend({

  messages: Ember.A(),

  growl(code) {
    let message;

    switch (code) {
      case 1:
        message = 'Logged out';
        break;
      case 2:
        message = 'Logged in';
        break;
      case 3:
        message = 'You may now Activate.';
        break;
      case 4:
        message = 'You are waiting for other players.';
        break;
      case 5:
        message = 'You have been activated and are now in-game.';
        break;
      case 6:
        message = 'Queue entered. You are waiting to play.';
        break;
      case 7:
        message = 'Queue exited. You are inactive.';
        break;
      case 8:
        message = 'Success! Target Found.';
        break;
      case 9:
        message = 'Success! Stalker exposed.';
        break;
      case 10:
        message = 'Failed... You exposed yourself.';
        break;
      case 11:
        message = 'You were found by your Stalker!';
        break;
      case 12:
        message = 'You were exposed by your target!';
        break;
      case 13:
        message = 'You are being watched.';
        break;
      default:
        message = code;
    }

    console.log('growled', message);
    this.get('messages').pushObject(message);
  }
});