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

  // computed
  @alias('geolocation.accuracy') accuracy,
  @alias('session.me') me,

  @computed('accuracy')
  locationIsAccurate() {
    if (typeof cordova === 'undefined') {
      return this.get('accuracy') < 100;
    } else {
      return true;
    }
  },

  // events
  init() {
    this.transmittingChanged();
    //@setInternetConnectionListeners()
  },

  transmittingChanged: observer('isTransmitting', function() {
    let isTransmitting = this.get('isTransmitting');
    let intervalID = this.get('intervalID');
    console.log('transmittingChanged', isTransmitting);
    console.log(this.get('session').get('active'), this.get('locationIsAccurate'), this.get('hasInternetConnection'));
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
    let location = this.get('geolocation').get('object');
    this.get('store').createRecord('location', location).save();
    me.set('stealth', me.get('stealth') + 1);
  },

  setLocationInterval() {
    console.log('setLocationInterval');
    let sendLocation = bind(this, this.sendLocation);
    setInterval(sendLocation, 60000);
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