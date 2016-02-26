import Ember from 'ember';
import computed from 'ember-computed-decorators';

const {
  Service,
  inject: { service },
  RSVP: { Promise }
} = Ember;

export default Service.extend({

  // services
  store: service(),

  // attributes
  appVersion: 2,
  remoteVersions: null,
  remoteVersion: null,
  updateApp: false,
  iosLink: 'http://itunes.apple.com/app/id998182913',
  androidLink: 'market://details?id=com.stalkersgame',
  
  // computed
  @computed
  updateLink() {
    if (typeof device != 'undefined') {
      if (this.androidDevice()) {
        return this.get('androidLink');
      } else {
        return this.get('iosLink');
      }
    }
  },

  async checkUpdate() {
    await this.getRemoteVersions();
    if (typeof device != 'undefined') {
      this.setRemoteVersion();
      localVersion = this.get('appVersion');
      remoteVersion = this.get('remoteVersion');
      if (remoteVersion > localVersion) {
        this.set('updateApp', true);
      }
    }
    return this.get('updateApp');
  },

  // helpers
  getRemoteVersions() {
    return new Promise((resolve) => {
      this.get('store').findAll('version')
      .then((versions) => {
        this.set('remoteVersions', versions);
        resolve();
      });
    });
  },

  setRemoteVersion() {
    let versions = this.get('remoteVersions');
    if (this.androidDevice()) {
      this.set('remoteVersion', versions.filterBy('platform','android').get('firstObject').get('revision'));
    } else {
      this.set('remoteVersion', versions.filterBy('platform','ios').get('firstObject').get('revision'));
    }
  },

  androidDevice() {
    return device.platform === 'android' || device.platform === 'Android';
  }
});