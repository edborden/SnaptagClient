import Ember from 'ember';
import { alias } from 'ember-computed-decorators';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  growler: service(),
  @alias('growler.messages') messages,

  actions: {
    remove(message) {
      this.get('messages').removeObject(message);
    }
  }

});