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
  modal: null,
  showInfo: false,
  activeSuspect: null,
  length: null,

  // computed
  @alias('session.me') me,
  @equal('modal', 'me') showMe,
  @equal('modal', 'web') showWeb,
  @equal('modal', 'pic') showPic,
  @equal('modal', 'notifications') showNotifications,
  @equal('modal', 'instructions') showInstructions,

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

  // events
  init() {
    this._super();
    this.get('eventer').on('resetUI', this, this.sendToggle);
  },

  willDestroyElement() {
    this.get('eventer').off('resetUI', this, this.sendToggle);
  },

  sendToggle() {
    this.send('toggle');
  },

  // actions
  sendLogout: 'logout',
  sendFound: 'found',
  sendExpose: 'expose',

  actions: {
    closer() {
      if (this.get('showPic')) {
        this.send('closePic');
      } else {
        this.send('toggle');
      }
    },
    toggle() {
      this.set('modal', null);
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
    }
  }

});