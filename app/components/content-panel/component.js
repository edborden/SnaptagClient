import Ember from 'ember';
import AutoCloser from '../auto-closer/component';

export default AutoCloser.extend({

  // attributes
  upper: false,
  scrolling: false,
  full: false,
  styled: true,
  closer: false,

  didInsertElement() {
    let height = this.$().children().last().height();
    this.$().children().first().height(height);
  }

});