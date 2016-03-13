import MapInterface from 'stalkers-client/components/map-interface/component';
import layout from 'stalkers-client/components/search-interface/template';

export default MapInterface.extend({

  layout,
  sendLogin: 'login',

  actions: {
    login() {
      this.sendAction('sendLogin');
    }
  }

});