import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  layoutName: 'loading',

  click() {
    return false;
  }

});