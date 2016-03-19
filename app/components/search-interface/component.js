import MapInterface from '../map-interface/component';
import layout from '../search-interface/template';
import InfoHelpers from '../../mixins/info-helpers';

export default MapInterface.extend(InfoHelpers, {

  layout,
  sendLogin: 'login',

  actions: {
    login() {
      this.sendAction('sendLogin');
    }
  }

});