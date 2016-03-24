import Ember from 'ember';

const {
  Controller,
  inject: { service }
} = Ember;

export default Controller.extend({

  // services
  geolocation: service(),
  keen: service(),

  // attributes
  error: null,
  waiting: false,

  // actions
  actions: {
    confirm() {
      this.set('error', null);
      this.set('waiting', true);
      let geolocation = this.get('geolocation');
      let keen = this.get('keen');
      geolocation.init();
      geolocation.get('promise').then(() => {
        keen.addEvent('geolocationSuccess');
        localStorage.snaptagLocation = true;
        this.transitionToRoute('search');
      }, (error) => {
        keen.addEvent('geolocationError', error);
        this.set('waiting', false);
        this.set('error', error);
      });
    },
    cancel() {
      this.get('keen').addEvent('geolocationCancel');
      this.set('error', null);
      this.transitionToRoute('search');
    }
  }
});