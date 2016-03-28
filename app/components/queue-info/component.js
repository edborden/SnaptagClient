import Ember from 'ember';
import { alias, equal } from 'ember-computed-decorators';
import computed from 'ember-computed-decorators';

const {
  Component,
  inject: { service },
  isEqual
} = Ember;

export default Component.extend({

  // services
  session: service(),

  // attributes
  model: null,

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
  }

});