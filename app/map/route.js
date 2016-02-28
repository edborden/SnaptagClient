import Ember from 'ember';

const {
  Route,
  inject: { service }
} = Ember;

export default Route.extend({

  session: service(),

  model() {
    return this.get('session').get('me').get('targets').getEach('location');
  }

});