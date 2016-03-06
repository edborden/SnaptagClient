import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  // attributes
  upper: false,
  scrolling: false,
  full: false,
  styled: true,

  didInsertElement() {
    let height = this.$().children().last().height();
    this.$().children().first().height(height);
  }

});