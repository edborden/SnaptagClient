import Ember from 'ember';
import MapInterface from '../map-interface/component';
import { alias, equal } from 'ember-computed-decorators';
import computed from 'ember-computed-decorators';
import layout from '../queue-interface/template';

const {
  inject: { service },
  isEqual
} = Ember;

export default MapInterface.extend({

  // services
  session: service(),

  // attributes
  layout,
  model: null,
  modal: 'info',
  sendUnjoin: 'unjoin',

  // computed
  @alias('session.me') me,
  @alias('me.activationqueue') activationqueue,
  @alias('activationqueue.usersCount') usersCount,
  @alias('activationqueue.zone.active') activeQueueZone,

  @computed('usersCount')
  queueOtherUsersCount() {
    if (isEqual(this.get('usersCount'), 1)) {
      return 'No';
    } else {
      return this.get('usersCount') - 1;
    }
  },

  @computed('usersCount')
  playersTillStartCount() {
    return 4 - this.get('usersCount');
  },

  // actions
  actions: {
    unjoin() {
      this.sendAction('sendUnjoin');
    }
  }

});