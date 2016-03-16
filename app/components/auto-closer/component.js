import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  action: 'closer',
  closer: false,

  click() {
    if (this.get('closer')) {
      this.sendAction();
    }
    return false;
  }

});