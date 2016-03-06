import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('search');
  this.authenticatedRoute('inactive');
  this.authenticatedRoute('queue');
  this.authenticatedRoute('active');
});

export default Router;
