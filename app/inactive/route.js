import Ember from 'ember';
import ZoneModel from '../mixins/zone-model';
import RequiresLocation from '../mixins/requires-location';
import ChecksStatus from '../mixins/checks-status';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(ZoneModel, RequiresLocation, ChecksStatus, {

  growler: service(),

  // events
  afterModel() {
    this.get('growler').growl(3);
  }

});