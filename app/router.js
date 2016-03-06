import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('search');
  this.authenticatedRoute('active');
  this.authenticatedRoute('inactive');
  this.authenticatedRoute('queue');
});

export default Router;
