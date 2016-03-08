import Ember from 'ember';
import { alias } from 'ember-computed-decorators';
import ZoneModel from 'stalkers-client/mixins/zone-model';
import RequiresLocation from 'stalkers-client/mixins/requires-location';
import ChecksStatus from 'stalkers-client/mixins/checks-status';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(ZoneModel, RequiresLocation, ChecksStatus, {

  // services
  session: service(),

  // computed
  @alias('session.me') me,

  beforeModel() {
    let isAuthenticated = this.get('session').get('isAuthenticated');
    if (isAuthenticated) {
      let status = this.get('me').get('status');
      this.replaceWith(status);
    }
    return this._super();
  }

});