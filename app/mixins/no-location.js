import Ember from 'ember';

const {
  Mixin,
  inject: { service }
} = Ember;

export default Mixin.create({

  init() {
    this._super();
    if (!localStorage.snaptagLocation) {
      this.set('noLocation', true);
    }
  }

});