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
      case 5:
        message = "Success! You're in the game!";
        break;
      case 7:
        message = 'You left the queue.';
        break;
      case 8:
        message = 'Success! Target Found.';
        break;
      case 9:
        message = 'Success! You counter-tagged your hunter!';
        break;
      case 10:
        message = 'Failed... You guessed wrong and have been booted.';
        break;
      case 11:
        message = 'You got Snaptagged! Bummer!';
        break;
      case 12:
        message = 'You were counter-tagged by your target! Be more careful!';
        break;
      default:
        message = code;
    }

    this.get('messages').pushObject(message);
  }
});