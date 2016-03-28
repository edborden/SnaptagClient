import MapInterface from '../map-interface/component';
import layout from '../search-interface/template';
import InfoHelpers from '../../mixins/info-helpers';
import NoLocation from '../../mixins/no-location';

export default MapInterface.extend(InfoHelpers, NoLocation, {

  layout,
  sendLogin: 'login',
  sendLoginJoin: 'loginJoin',

  actions: {
    login() {
      this.sendAction('sendLogin');
    },
    setModal(name, type) {
      this.sendAction('setModal', name, type);
    },
    loginJoin() {
      this.sendAction('sendLoginJoin');
    }
  }

});