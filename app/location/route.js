import Ember from 'ember';
import KeenRoute from '../mixins/keen-route';

const {
  Route
} = Ember;

export default Route.extend(KeenRoute, {

  beforeModel() {
    if (localStorage.snaptagLocation) {
      this.replaceWith('search');
    }
  }

});