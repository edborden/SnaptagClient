import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('intro1');
  this.route('intro2');
  this.route('intro3');
  this.route('location');
  this.route('search');
  this.authenticatedRoute('inactive');
  this.authenticatedRoute('queue');
  this.authenticatedRoute('active');
});

export default Router;
