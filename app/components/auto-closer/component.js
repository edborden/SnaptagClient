import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  action: 'closer',

  click() {
    this.sendAction();
    return false;
  }

});