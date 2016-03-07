import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias } from 'ember-computed-decorators';

const {
  Service,
  inject: { service },
  run: { bind },
  observer,
  isBlank,
  isPresent
} = Ember;

export default Service.extend({

  // services
  store: service(),
  session: service(),
  geolocation: service(),

  // attributes
  intervalID: null,
  hasInternetConnection: true,

  // computed
  @alias('geolocation.accuracy') accuracy,
  @alias('session.me') me,
  @alias('me.active') active,

  @computed('accuracy')
  locationIsAccurate() {
    return this.get('accuracy') < 100;
  },

  @computed('active', 'locationIsAccurate', 'hasInternetConnection')
  isTransmitting() {
    let active = this.get('active');
    let locationIsAccurate = this.get('locationIsAccurate');
    let hasInternetConnection = this.get('hasInternetConnection');
    return active && locationIsAccurate && hasInternetConnection;
  },

  // events
  init() {
    this.transmittingChanged();
    // @setInternetConnectionListeners()
  },

  // this does not function correctly after logout, still sends location
  transmittingChanged: observer('isTransmitting', function() {
    let isTransmitting = this.get('isTransmitting');
    let intervalID = this.get('intervalID');
    console.log('transmittingChanged', isTransmitting);
    if (isTransmitting && isBlank(intervalID)) {
      this.set('intervalID', this.setLocationInterval());
    }
    if (isTransmitting === false && isPresent(intervalID)) {
      console.log('clearInterval');
      clearInterval(intervalID);
      this.set('intervalID', null);
    }
  }),

  sendLocation() {
    console.log('sendLocation');
    let me = this.get('me');
    let location = this.get('geolocation').getObject();
    this.get('store').createRecord('location', location).save();
    me.set('stealth', me.get('stealth') + 1);
  },

  setLocationInterval() {
    console.log('setLocationInterval');
    let sendLocation = bind(this, this.sendLocation);
    return setInterval(sendLocation, 60000);
  }

  /*

  setInternetConnectionListeners: ->
    if cordova?
      document.addEventListener("online", @onOnline, false)
      document.addEventListener("offline", @onOffline, false)
    else
      @hasInternetConnection = true

  onOnline: ->
    console.log "internet connection went online"
    unless @hasInternetConnection
      @hasInternetConnection = true
      document.addEventListener("online", @onOnline, false)

  onOffline: ->
    console.log "inernet connection went offline"
    if @hasInternetConnection
      @hasInternetConnection = false
      document.addEventListener("offline", @onOffline, false)
  */
});