import Ember from 'ember';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  action: 'toggle',

  click() {
    this.sendAction();
  }

});