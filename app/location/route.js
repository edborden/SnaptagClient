import Ember from 'ember';

const {
  Route
} = Ember;

export default Route.extend({

  beforeModel() {
    if (localStorage.snaptagLocation) {
      this.replaceWith('search');
    }
  }
  
});