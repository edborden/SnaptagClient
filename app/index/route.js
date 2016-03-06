import Ember from 'ember';
import { alias } from 'ember-computed-decorators';
import ZoneModel from 'stalkers-client/mixins/zone-model';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend(ZoneModel, {

  // services
  updater: service(),
  session: service(),

  // computed
  @alias('session.me') me,

  beforeModel() {
    let shouldUpdateApp = this.get('updater').get('updateApp');
    let me = this.get('me');

    if (shouldUpdateApp) {
      this.replaceWith('update');
    } else {
      let isAuthenticated = this.get('session').get('isAuthenticated');
      if (isAuthenticated) {
        if (me.get('active')) {
          this.replaceWith('active');
        } else {
          if (me.get('inactive') || me.get('queue')) {
            this.replaceWith('inactive');
          }
        }
      }
    }
  }

});