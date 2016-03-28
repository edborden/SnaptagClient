import Ember from 'ember';

const {
  Service
} = Ember;

export default Service.extend({

  // attributes
  show: false,
  model: null,
  component: null,
  partial: null,

  // helpers
  closer() {
    if (this.get('showPic')) {
      this.closePic();
    } else {
      this.closeModal();
    }
  },

  setModal(name, type, model) {
    this.set('show', true);
    this.set(type, name);
    this.set('model', model);
  },

  closeModal() {
    this.set('show', false);
    this.set('component', null);
    this.set('partial', null);
  }
  
});