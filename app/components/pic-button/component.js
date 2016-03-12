import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  setModal: 'setModal',

  click() {
    this.sendAction('setModal', 'pic');
  }

});