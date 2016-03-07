import Ember from 'ember';

const {
  Controller,
  inject: { service }
} = Ember;

export default Controller.extend({

  // services
  geolocation: service(),

  // attributes
  error: null,

  // actions
  actions: {
    confirm() {
      this.set('error', null);
      this.get('geolocation').get('promise').then(() => {
        this.transitionToRoute('search');
      }, (error) => {
        this.set('error', error);
      });
    },
    cancel() {
      this.transitionToRoute('index');
    }
  }
});