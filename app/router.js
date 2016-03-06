import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.authenticatedRoute('active');
  this.authenticatedRoute('inactive');
  this.route('update');
});

export default Router;
