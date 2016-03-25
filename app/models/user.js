import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias, filterBy, equal } from 'ember-computed-decorators';
import DS from 'ember-data';

const {
  Model,
  attr,
  belongsTo,
  hasMany
} = DS;

const {
  inject: { service },
  isEqual,
  isPresent
} = Ember;

export default Model.extend({

  // services
  session: service(),

  // attributes
  name: attr('string'),
  targetsFoundCount: attr('number'),
  foundCount: attr('number'),
  stalkersExposedCount: attr('number'),
  exposedCount: attr('number'),
  stealth: attr('number'),
  activatedAt: attr('date'),
  status: attr('string'),
  facebookid: attr('string'),

  // associations
  activationqueue: belongsTo('activationqueue', { async: false }),
  suspects: hasMany('user', { inverse: null, async: false }),
  targets: hasMany('user', { inverse: null, async: false }),
  notifications: hasMany('notification', { async: false }),
  locations: hasMany('location', { async: false }),
  zone: belongsTo('zone', { async: false }),

  // computed
  @alias('session.me.targets') meTargets,
  @alias('locations.lastObject') location,
  @equal('status', 'active') active,
  @equal('status', 'queue') queue,
  @equal('status', 'inactive') inactive,

  // this errors if there isn't a session
  @computed('meTargets')
  isTarget() {
    let meTargets = this.get('meTargets');
    if (isPresent(meTargets)) {
      return this.get('meTargets')
      .any((user) => {
        return isEqual(user, this);
      });
    } else {
      return false;
    }
  },

  @filterBy('notifications', 'read', false) unreadNotifications

});