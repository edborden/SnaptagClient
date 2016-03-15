import Ember from 'ember';

const {
  Mixin,
  inject: { service }
} = Ember;

export default Mixin.create({

  // services
  session: service(),

  beforeModel() {
    let session = this.get('session');
    let isAuthenticated = session.get('isAuthenticated');
    if (isAuthenticated) {
      let status = session.get('me').get('status');
      let routeName = this.get('routeName');
      console.log(status, routeName);
      if (status != routeName) {
        this.replaceWith(status);
      }
    }
    return this._super();
  }

});