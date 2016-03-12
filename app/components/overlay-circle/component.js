import Ember from 'ember';
import computed from 'ember-computed-decorators';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  // attributes
  'top-right': false,
  'top-left': false,
  color: 'red',
  classNameBindings: [ 'top-right', 'top-left', 'blue', 'red' ],

  // computed
  @equal('color', 'red') red,
  @equal('color', 'blue') blue  

});