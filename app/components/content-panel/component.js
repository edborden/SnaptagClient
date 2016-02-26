import Ember from 'ember';

const {
  Component
} = Ember;

export default Component.extend({

  didInsertElement() {
    let height = this.$().children().last().height();
    this.$().children().first().height(height);
  }

});