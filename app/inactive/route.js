import Ember from 'ember';
import ZoneModel from 'stalkers-client/mixins/zone-model';
import RequiresLocation from 'stalkers-client/mixins/requires-location';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(ZoneModel, RequiresLocation, {

  growler: service(),

  // events
  afterModel() {
    this.get('growler').growl(3);
  }

});