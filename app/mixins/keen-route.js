import Ember from 'ember';

const {
  Mixin,
  inject: { service }
} = Ember;

export default Mixin.create({

  // services
  keen: service(),

  afterModel() {
    this._super();
    this.get('keen').addEvent(this.get('routeName'));
  }

});