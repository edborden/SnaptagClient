import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias, equal } from 'ember-computed-decorators';

const {
  Component,
  run: { later }
} = Ember;

export default Component.extend({

  // attributes
  tagName: 'h3',
  action: 'remove',
  content: null,

  // events
  didInsertElement() {
    later(this, this.onFinish, 2000);
  },

  onFinish() {
    this.$().fadeOut(3000, () => {
      this.sendAction('action', this.get('content'));
    });
  }

});