import MapInterface from '../map-interface/component';
import layout from '../inactive-interface/template';

export default MapInterface.extend({

  layout,
  length: null,

  sendJoin: 'join',

  actions: {
    join() {
      this.sendAction('sendJoin');
    }
  }

});