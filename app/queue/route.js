import Ember from 'ember';
import ZoneModel from 'stalkers-client/mixins/zone-model';

const {
  Route
} = Ember;

export default Route.extend(ZoneModel, {

  // events
  beforeModel() {
    this.get('growler').growl(4);
  }

});