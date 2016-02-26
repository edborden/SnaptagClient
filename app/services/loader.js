import Ember from 'ember';

const {
  Service,
  isBlank
} = Ember;

export default Service.extend({

  in() {
    if (typeof cordova != 'undefined') {
      window.plugins.spinnerDialog.show(null, null, true);
    } else {
      return;
    }
  },

  out() {
    if (typeof cordova != 'undefined') {
      window.plugins.spinnerDialog.hide();
    } else {
      return;
    }
  }
});