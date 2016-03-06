import Ember from 'ember';

const {
  Controller,
  inject: { service }
} = Ember;

export default Controller.extend({

  // services
  geolocation: service(),

  // attributes
  location: false,
  error: null,

  // actions
  actions: {
    location() {
      this.toggleProperty('location');
    },
    confirm() {
      this.get('geolocation').get('promise').then(() => {
        console.log('geolocation successful in contr');
        this.transitionToRoute('search');
      }, (error) => {
        console.log('unsuccessful');
        this.set('error', error);
      });
    }
  }
});