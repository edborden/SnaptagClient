import MapInterface from '../map-interface/component';
import layout from '../inactive-interface/template';
import InfoHelpers from '../../mixins/info-helpers';

export default MapInterface.extend(InfoHelpers, {

  layout,
  length: null,
  modal: 'info',

  sendJoin: 'join',

  actions: {
    join() {
      this.sendAction('sendJoin');
    }
  }

});