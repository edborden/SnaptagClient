import Ember from 'ember';
import MapInterface from '../map-interface/component';
import layout from '../active-interface/template';
/* global cloudinary */

const {
  isPresent
} = Ember;

export default MapInterface.extend({

  layout,

  sendFound: 'sendFound',
  actions: {

    found(imageId) {
      this.sendAction('sendFound', this.get('activeSuspect'), imageId);
      this.set('activeSuspect', null);
      this.send('closeModal');
    },

    file() {
      // jscs:disable requireCamelCaseOrUpperCaseIdentifiers
      cloudinary.openUploadWidget({
        upload_preset: 'fftdsikd',
        cropping: 'server'
      }, (error, result) => {
        console.log(error, result);
        if (isPresent(result)) {
          this.send('found', result[0].public_id);
        }
      });
    }
  }

});