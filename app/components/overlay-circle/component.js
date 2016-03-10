import Ember from 'ember';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  // attributes
  'top-right': false,
  'top-left': false,
  blue: false,
  red: false,
  classNameBindings: [ 'top-right', 'top-left', 'blue', 'red' ]

});