import Ember from 'ember';
import { alias, equal } from 'ember-computed-decorators';
import computed from 'ember-computed-decorators';
import { locationInZone } from '../utils/geo-helpers';

const {
  Mixin,
  inject: { service }
} = Ember;

export default Mixin.create({

  // services
  geolocation: service(),

  // attributes
  model: null,

  // computed
  @equal('model.length', 0) noPlayers,

  @computed
  inZone() {
    let model = this.get('model');
    let location = this.get('geolocation').getEmberObject();
    let inZoneArray = model.filter((zone) => {
      return locationInZone(location, zone);
    });
    return inZoneArray.get('firstObject');
  },

  // events
  init() {
    this._super();
    if (this.get('noPlayers')) {
      this.set('modal', 'info');
    }
  }

});