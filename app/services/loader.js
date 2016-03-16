import Ember from 'ember';

const {
  Service
} = Ember;

export default Service.extend({

  show: false,

  in() {
    this.set('show', true);
  },

  out() {
    this.set('show', false);
  }
});