import Ember from 'ember';
import ZoneModel from 'stalkers-client/mixins/zone-model';
import RequiresLocation from 'stalkers-client/mixins/requires-location';
import ChecksStatus from 'stalkers-client/mixins/checks-status';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(ZoneModel, RequiresLocation, ChecksStatus, {

  growler: service(),

  // events
  afterModel() {
    this.get('growler').growl(4);
  }

});