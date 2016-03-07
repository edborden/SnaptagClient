import Ember from 'ember';

const {
  Mixin,
  inject: { service }
} = Ember;

export default Mixin.create({

  // services
  geolocation: service(),

  beforeModel() {
    this._super();
    return this.get('geolocation').get('promise');
  }

});