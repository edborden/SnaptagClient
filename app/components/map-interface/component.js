import Ember from 'ember';
import config from '../../config/environment';
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
  modaler: service(),

  // attributes
  modal: null,
  activeSuspect: null,
  length: null,

  // computed
  @alias('session.me') me,
  @equal('modal', 'me') showMe,
  @equal('modal', 'web') showWeb,
  @equal('modal', 'pic') showPic,
  @equal('modal', 'notifications') showNotifications,
  @equal('modal', 'instructions') showInstructions,
  @equal('modal', 'expose') showExpose,
  @equal('modal', 'found') showFound,
  @equal('modal', 'logout') showLogout,
  @equal('modal', 'info') showInfo,

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

  sendToggle() {
    this.send('closeModal');
  },

  // actions
  sendLogout: 'logout',
  sendExpose: 'expose',
  setModal: 'setModal',
  closeModal: 'closeModal',

  actions: {
    closeModal() {
      this.set('modal', null);
    },
    setModal(name, type) {
      this.sendAction('setModal', name, type);
    },
    me() {
      let hasUnreadNotifications = isPresent(this.get('me').get('unreadNotifications'));
      if (this.get('meButtonActive')) {
        if (hasUnreadNotifications && this.get('showNotifications')) {
          this.set('modal', 'me');
          this.set('activeSuspect', null);
        } else {
          if (this.get('showPic') || this.get('showNotifications')) {
            this.set('modal', 'me');
          } else {
            this.set('modal', null);
          }
        }
      } else {
        if (hasUnreadNotifications) {
          this.set('modal', 'notifications');
        } else {
          this.set('modal', 'me');
          this.set('activeSuspect', null);
        }
      }
    },
    web() {
      if (this.get('showWeb')) {
        this.set('modal', null);
      } else {
        this.set('modal', 'web');
      }
    },
    setModal(name) {
      let modal = this.get('modal');
      if (modal === name) {
        this.send('closeModal');
      } else {
        this.set('modal', name);
      }
    },
    closePic() {
      if (isPresent(this.get('activeSuspect'))) {
        this.set('modal', 'web');
      } else {
        this.set('modal', 'me');
      }
    },
    expose() {
      this.sendAction('sendExpose', this.get('activeSuspect'));
      this.set('activeSuspect', null);
      this.send('closeModal');
    },
    logout() {
      this.sendAction('sendLogout');
    },
    suspectClicked(suspect) {
      this.set('activeSuspect', suspect);
    }
  }

});