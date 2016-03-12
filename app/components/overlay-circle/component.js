import Ember from 'ember';
import { equal } from 'ember-computed-decorators';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  // attributes
  'top-right': false,
  'top-left': false,
  color: 'red',
  classNameBindings: [ 'top-right', 'top-left', 'white', 'red' ],

  // computed
  @equal('color', 'red') red,
  @equal('color', 'white') white  

});