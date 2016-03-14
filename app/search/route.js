import Ember from 'ember';
import ZoneModel from '../mixins/zone-model';
import RequiresLocation from '../mixins/requires-location';
import ChecksStatus from '../mixins/checks-status';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(ZoneModel, RequiresLocation, {

  // services
  session: service(),

  beforeModel() {
    let isAuthenticated = this.get('session').get('isAuthenticated');
    if (isAuthenticated) {
      let status = this.get('session').get('me').get('status');
      this.replaceWith(status);
    }
    return this._super();
  }

});