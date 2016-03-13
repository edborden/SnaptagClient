import MapInterface from 'stalkers-client/components/map-interface/component';
import layout from 'stalkers-client/components/queue-interface/template';

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