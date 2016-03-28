import Ember from 'ember';

const {
  Service
} = Ember;

export default Service.extend({

  // attributes
  show: false,
  modal: null,
  partial: null,

  // helpers
  closer() {
    if (this.get('showPic')) {
      this.closePic();
    } else {
      this.closeModal();
    }
  },

  setModal(name, type) {
    this.set('show', true);
    this.set(type, name);
  },

  closeModal() {
    this.set('show', false);
    this.set('component', null);
    this.set('partial', null);
  }
  
});