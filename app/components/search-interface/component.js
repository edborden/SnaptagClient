import MapInterface from '../map-interface/component';
import layout from '../search-interface/template';

export default MapInterface.extend({

  layout,
  sendLogin: 'login',

  actions: {
    login() {
      this.sendAction('sendLogin');
    }
  }

});