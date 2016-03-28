import Ember from 'ember';

const {
  Controller,
  inject: { service }
} = Ember;

export default Controller.extend({

  // services
  loader: service(),
  modaler: service()

});