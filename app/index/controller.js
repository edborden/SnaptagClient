import Ember from 'ember';

const {
  Controller
} = Ember;

export default Controller.extend({

  showInstructions: false,

  actions: {
    instructions() { 
      this.toggleProperty('showInstructions');
    }
  }  
});