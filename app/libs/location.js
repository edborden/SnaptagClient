// Generated by CoffeeScript 1.6.3
var Location;

Location = Ember.Object.extend({
  currentVal: null,
  init: function() {
    this._super();
    navigator.geolocation.getCurrentPosition(this.handle_geolocation_response);
    return navigator.geolocation.watchPosition(this.handle_geolocation_response, null, {
      enableHighAccuracy: true
    });
  },
  handle_geolocation_response: function(position) {
    console.log(position.coords.latitude, position.coords.longitude, position.coords.accuracy, position.timestamp);
    return console.log(this.currentVal);
  },
  updateCurrent: function() {
    return navigator.geolocation.getCurrentPosition(this.handle_geolocation_response);
  }
});

export default Location;
