import Ember from 'ember';
/* global cloudinary */

const {
  isPresent,
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  session: service(),
  sendFound: 'found',
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
    },
  }

});