import Ember from 'ember';

const {
  Controller
} = Ember;

export default Controller.extend({

  onGeolocationSuccess: Ember.observer('geolocation.success', function() {
    if (this.get('geolocation').get('success')) {
      this.transitionToRoute('index');
    }
  }),

  showInstructions: false,

  actions: {
    instructions() { 
      this.toggleProperty('showInstructions');
    }
  }  
});