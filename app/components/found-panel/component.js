import Ember from 'ember';
/* global cloudinary */

const {
  isPresent,
  Component
} = Ember;

export default Component.extend({

  model: null,
  sendFound: 'found',
  actions: {

    found(imageId) {
      this.sendAction('sendFound', this.get('model'), imageId);
      this.set('activeSuspect', null);
      this.closeModal();
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