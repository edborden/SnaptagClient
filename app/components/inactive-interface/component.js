import MapInterface from 'stalkers-client/components/map-interface/component';
import layout from 'stalkers-client/components/inactive-interface/template'

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