import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  messages: null,

  actions: {
    remove(message) {
      this.get('messages').removeObject(message);
    }
  }

});