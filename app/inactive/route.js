import Ember from 'ember';
import ZoneModel from 'stalkers-client/mixins/zone-model';
import RequiresLocation from 'stalkers-client/mixins/requires-location';

const {
  Route
} = Ember;

export default Route.extend(ZoneModel, RequiresLocation, {

  // events
  beforeModel() {
    this.get('growler').growl(3);
  }

});