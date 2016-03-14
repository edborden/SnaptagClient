import MapInterface from '../map-interface/component';
import layout from '../queue-interface/template';

export default MapInterface.extend({

  layout,
  length: null,

  sendUnjoin: 'unjoin',

  actions: {
    unjoin() {
      this.sendAction('sendUnjoin');
    }
  }

});