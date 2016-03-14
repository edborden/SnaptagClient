import MapInterface from '../map-interface/component';
import layout from '../queue-interface/template';
import InfoHelpers from '../../mixins/info-helpers';

export default MapInterface.extend(InfoHelpers, {

  layout,
  length: null,
  modal: 'info',

  sendUnjoin: 'unjoin',

  actions: {
    unjoin() {
      this.sendAction('sendUnjoin');
    }
  }

});