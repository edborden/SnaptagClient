import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  action: null,
  active: null,
  classNameBindings: [ 'active' ],

  click() {
    switch (typeof this.get('action')) {
      case 'string':
        this.sendAction();
        break;
      case 'function':
        this.action();
        break;
    }
  }

});