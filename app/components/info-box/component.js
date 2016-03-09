import Ember from 'ember';
import config from 'stalkers-client/config/environment';
import computed from 'ember-computed-decorators';
import { alias, equal } from 'ember-computed-decorators';

const {
  Component,
  inject: { service },
  isPresent,
  isBlank,
  isEqual
} = Ember;

export default Component.extend({

  // services
  session: service(),
  transmit: service(),
  eventer: service(),

  // attributes
  show: false,
  length: null,

  // computed
  @alias('session.me') me,

  // events
  init() {
    this._super();
    this.get('eventer').on('resetUI', this, this.sendToggle);
  },

  willDestroyElement() {
    this.get('eventer').off('resetUI', this, this.sendToggle);
  },

  // actions
  actions: {
    toggle() {
      this.set('modal', null);
    },

    show() {
      this.toggleProperty('show');
    }
  },

  // info box
  @alias('me.activationqueue') activationqueue,
  @alias('activationqueue.usersCount') usersCount,
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
  },
  @alias('activationqueue.zone.active') activeQueueZone

});