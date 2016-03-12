import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  action: null,
  active: null,
  classNameBindings: [ 'active' ],

  click() {
    if (typeof this.get('action') === 'string') {
      this.sendAction();
    } else {
      this.action();
    }
  }

});