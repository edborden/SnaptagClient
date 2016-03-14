import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias, equal } from 'ember-computed-decorators';

const {
  Mixin,
  inject: { service },
  isEqual
} = Ember;

export default Mixin.create({

  // services
  session: service(),

  // attributes
  length: null,

  // computed
  @alias('session.me') me,
  @alias('me.activationqueue') activationqueue,
  @alias('activationqueue.usersCount') usersCount,
  @alias('activationqueue.zone.active') activeQueueZone,
  @equal('length', 0) noPlayers,

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
    return 12 - this.get('usersCount');
  }

});