import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  action: 'toggle',

  click() {
    this.sendAction();
    return false;
  }

});