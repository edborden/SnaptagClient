import Ember from 'ember';
import { alias } from 'ember-computed-decorators';

const {
  Service,
  inject: { service }
} = Ember;

export default Service.extend({

  // services
  growler: service(),
  session: service(),
  realtime: service(),
  store: service(),
  loader: service(),
  routing: service('-routing'),
  eventer: service(),

  // computed
  @alias('session.me') me,
  @alias('me.activationqueue') activationqueue,
  @alias('activationqueue.zone') zone,

  action(message, data) {
    let me = this.get('me');
    let loader = this.get('loader');
    let routing = this.get('routing');
    let growler = this.get('growler');
    let realtime = this.get('realtime');
    let store = this.get('store');
    let eventer = this.get('eventer');
    let user;
    let location;
    let target;
    console.log('Executive received', message, data);

    switch (message) {

      case 'Target Found':

        me.get('suspects').removeObject(data);
        me.set('targetsFoundCount', me.get('targetsFoundCount') + 1);
        loader.out();
        eventer.trigger('resetUI');
        growler.growl(8);
        break;

      case 'Stalker exposed':

        data.deleteRecord();
        me.notifyPropertyChange('suspects');
        loader.out();
        eventer.trigger('resetUI');
        growler.growl(9);
        break;

      case 'Exposed self':

        me.set('exposedCount', me.get('exposedCount') + 1);
        loader.out();
        this.goInactive();
        growler.growl(10);
        break;

      case 'Found':

        me.set('foundCount', me.get('foundCount') + 1);
        this.goInactive();
        growler.growl(11);
        break;

      case 'Exposed':

        me.set('exposedCount', me.get('exposedCount') + 1);
        this.goInactive();
        growler.growl(12);
        break;

      case 'Target removed':

        this.removeSuspect(data.get(notifiedObjectId));
        break;

      case 'New target':

        user = this.pushSuspect(data);
        me.get('targets').pushObject(user);
        user.notifyPropertyChange('isTarget');
        realtime.watchTarget(user);
        break;

      case 'New suspect':

        this.pushSuspect(data);
        break;

      case 'Suspect removed':

        this.removeSuspect(data);
        break;

      case 'Add user to activationqueue':

        user = this.pushUser(data);
        this.get('zone').get('users').pushObject(user);
        this.get('activationqueue').set('usersCount', this.get('activationqueue').get('usersCount') + 1);
        break;

      case 'Remove user from activationqueue':

        user = store.peekRecord('user', data);
        this.get('zone').get('users').removeObject(user);
        this.get('activationqueue').set('usersCount', this.get('activationqueue').get('usersCount') - 1);
        break;

      case 'New target location':
      
        store.pushPayload(data);
        location = store.peekRecord('location', data.location.id);
        target = location.get('user');
        target.get('locations').pushObject(location);
        target.notifyPropertyChange('latestLocation');
        this.get('map').notifyPropertyChange('latestLocations');
        break;

      case 'Added to activationqueue':

        loader.in();
        store.find('activationqueue', data.get('notifiedObjectId'))
        .then(function(activationqueue) {
          me.set('activationqueue', activationqueue);
          me.set('status', 'queue');
          loader.out()
          routing.transitionTo('inactivemap');
        });
        growler.growl(6);
        break;

      case 'You have entered the game':

        loader.in(); 
        this.get('session').fetch()
        .then(function() { 
          me.set('status', 'active');
          loader.out();
          routing.transitionTo('map');
        });
        growler.growl(5);
        break;
    }
  },

  // helpers
  goInactive() {
    let me = this.get('me');
    me.set('status', 'inactive');
    me.get('suspects').clear();
    me.get('targets').clear();
    this.get('routing').transitionTo('inactivemap');
  },

  pushUser(data) {
    let store = this.get('store');
    store.pushPayload(data);
    let user = store.peekRecord('user', data.user.id);   
    return user;
  },

  pushSuspect(data) {
    let me = this.get('me');
    let user = this.pushUser(data);
    me.get('suspects').pushObject(user);
    me.notifyPropertyChange('suspects');
    return user;
  },

  removeSuspect(userId) {
    let me = this.get('me');
    let user = this.get('store').peekRecord('user', userId);
    me.get('suspects').removeObject(user);
    me.get('targets').removeObject(user);
    me.notifyPropertyChange('suspects');
    user.deleteRecord()
  }
});