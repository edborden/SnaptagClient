import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias, filterBy } from 'ember-computed-decorators';
import DS from 'ember-data';

const {
  Model,
  attr,
  belongsTo,
  hasMany
} = DS;

const {
  inject: { service },
  isEqual
} = Ember

export default Model.extend({

  // services
  session: service(),

  // attributes
  name: attr('string'),
  targetsFoundCount: attr('number'),
  foundCount: attr('number'),
  stalkersExposedCount: attr('number'),
  exposedCount: attr('number'),
  smallpic: attr('string'),
  largepic: attr('string'),
  stealth: attr('number'),
  activatedAt: attr('date'),
  status: attr('string'),

  // associations
  activationqueue: belongsTo('activationqueue', { async: false }),
  suspects: hasMany('user', { inverse: null, async: false }),
  targets: hasMany('user', { inverse: null, async: false }),
  notifications: hasMany('notification', { async: false }),
  locations: hasMany('location', { async: false }),

  // computed
  @alias('session.me.targets') meTargets,
  @alias('locations.lastObject') location,
  
  // this errors if there isn't a session
  @computed('meTargets')
  isTarget() {
    return this.get('meTargets')
    .any((user) => {
      return isEqual(user, this);
    });
  },

  @filterBy('notifications', 'read', false) unreadNotifications

});