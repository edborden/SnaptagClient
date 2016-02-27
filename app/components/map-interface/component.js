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

  // attributes
  modal: null,
  showInfo: false,
  contentSection: true,
  activeSuspect: null,

  // computed
  @alias('session.me') me,
  @equal('modal', 'me') showMe,
  @equal('modal', 'web') showWeb,
  @equal('modal', 'pic') showPic,
  @equal('modal', 'notifications') showNotifications,
  @equal('modal', 'instructions') showInstructions,
  @equal('modal', null) showInfoButton,

  @computed('showWeb', 'showPic', 'activeSuspect')
  webButtonActive() {
    if (this.get('showWeb')) {
      return true;
    }
    if (this.get('showPic') && isPresent(this.get('activeSuspect'))) {
      return true;
    }
  },

  @computed('showMe', 'showPic', 'activeSuspect', 'showNotifications', 'showInstructions')
  meButtonActive() {
    if (this.get('showMe')) {
      return true;
    }
    if (this.get('showPic') && isBlank(this.get('activeSuspect'))) {
      return true;
    }
    if (this.get('showNotifications')) {
      return true;
    }
    if (this.get('showInstructions')) {
      return true;
    }
  },

  @computed('transmit.locationIsAccurate')
  locationAccurateText() {
    if (this.get('transmit').get('locationIsAccurate')) {
      return 'Your location is accurate.';
    } else {
      return 'Your location is not accurate enough (try turning on your GPS and your WiFi).';
    }
  },

  @computed('transmit.isTransmitting')
  isTransmittingText() {
    if (this.get('transmit').get('isTransmitting')) {
      return 'You are transmitting your location and accruing influence every 60 seconds.';
    } else {
      return 'You are not transmitting your location or accruing influence.';
    }
  },

  @computed('transmit.hasInternetConnection')
  hasInternetConnectionText() {
    if (this.get('transmit').get('hasInternetConnection')) {
      return 'You have an internet connection.';
    } else {
      return 'You do not have an internet connection.';
    }
  },

  // actions
  sendTarget: 'target',
  sendHistory: 'history',
  sendLogout: 'logout',
  sendFound: 'found',
  sendExpose: 'expose',

  actions: {
    toggle() {
      this.set('modal', null);
    },
    middle() {
      this.toggleProperty('contentSection');
    },
    me() {
      if (this.get('meButtonActive')) {
        this.set('modal', null);
      } else {
        this.set('modal', 'me');
        this.set('activeSuspect', null);
      }
    },
    web() {
      if (this.get('showWeb')) {
        this.set('modal', null);
      } else {
        this.set('modal', 'web');
      }
    },
    pic() {
      this.set('modal', 'pic');
    },
    closePic() { 
      this.set('showFound', false);
      this.set('showExpose', false);
      if (isPresent(this.get('activeSuspect'))) { 
        this.set('modal', 'web');
      } else {
        this.set('modal', 'me');
      }
    },
    target() {
      this.sendAction('sendTarget', this.get('activeSuspect'));
    },
    history() {
      this.sendAction('sendHistory', this.get('activeSuspect'));
    },
    showFound() {
      this.set('showFound', true);
      this.set('modal', 'pic');
    },
    showExpose() {
      this.set('showExpose', true);
      this.set('modal', 'pic');
    },
    found() {     
      this.sendAction('sendFound', this.get('activeSuspect'));
      this.set('activeSuspect', null);
    },
    expose() {
      this.sendAction('sendExpose', this.get('activeSuspect'));
      this.set('activeSuspect', null);
    },
    logout() {
      this.sendAction('sendLogout');
    },
    notifications() {
      this.set('modal', 'notifications');
    },
    instructions() {
      this.set('modal', 'instructions');
    },
    suspectClicked(suspect) {
      if (!this.get('contentSection')) {
        this.set('contentSection', true);
      }
      if (isEqual(this.get('activeSuspect'), suspect)) {
        this.set('activeSuspect', null);
      } else {
        this.set('activeSuspect', suspect);
      }
    },
    info() { 
      this.toggleProperty('showInfo');
    }
  },

  // info box
  @alias('session.me.activationqueue') activationqueue,
  @alias('activationqueue.usersCount') usersCount,
  @equal('length', 0) noPlayers,
  @computed('usersCount')
  queueOtherUsersCount() {
    if (isEqual(this.get('usersCount'), 0)) {
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