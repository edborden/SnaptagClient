import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('intro', function() {
    this.route('1');
    this.route('2');
    this.route('3');
  });
  this.route('location');
  this.route('search');
  this.route('guide');
  this.authenticatedRoute('inactive');
  this.authenticatedRoute('queue');
  this.authenticatedRoute('active');
  this.authenticatedRoute('penaltybox');
});

export default Router;
