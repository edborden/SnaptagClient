import Ember from 'ember';
import { alias } from 'ember-computed-decorators';
import ZoneModel from 'stalkers-client/mixins/zone-model';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(ZoneModel, {

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
  }

});