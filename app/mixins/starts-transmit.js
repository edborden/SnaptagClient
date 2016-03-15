import Ember from 'ember';

const {
  Mixin,
  inject: { service }
} = Ember;

export default Mixin.create({

  // services
  transmit: service(),

  async beforeModel() {
    await this._super();
    // instantiate transmit service
    this.get('transmit').get('isTransmitting');
  }

});