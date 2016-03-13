/*jshint node:true*/
/* global require, module */
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    fingerprint: {
      exclude: ['icons/','splash.png','images/','icon.png']
    },
    babel: {
      includePolyfill: true,
      optional: ['es7.decorators']
    },
    'ember-cli-qunit': {
      useLintTree: false
    },
    inlineContent: {
      favicon: { content: "<link rel='icon' href='/assets/images/favicon.ico'>" },
      cloudinary: {content: "<script src='//widget.cloudinary.com/global/all.js' type='text/javascript'></script>" }
    }
  });

  var pickFiles = require('broccoli-static-compiler');
  var mergeTrees = require('broccoli-merge-trees');

  // Bootstrap Popover
  app.import('bower_components/bootstrap/js/tooltip.js');
  app.import('bower_components/bootstrap/js/popover.js');

  // Pusher
  app.import('bower_components/pusher/dist/pusher.min.js');

  // Keen.io
  app.import('bower_components/keen-js/dist/keen.min.js');
  
  // Leaflet Awesome Markers
  app.import('bower_components/leaflet.awesome-markers/dist/leaflet.awesome-markers.js');
  app.import('bower_components/leaflet.awesome-markers/dist/leaflet.awesome-markers.css');
  var leafletAwesomeMarkers = pickFiles('bower_components/leaflet.awesome-markers/dist/images', {
      srcDir: '/',
    destDir: 'assets/images'
  });

  // Leaflet User Marker
  app.import('bower_components/leaflet-usermarker/src/leaflet.usermarker.js');
  app.import('bower_components/leaflet-usermarker/src/leaflet.usermarker.css');
  var leafletUserMarker = pickFiles('bower_components/leaflet-usermarker/src/img', {
      srcDir: '/',
    destDir: 'assets/images'
  });

  // Font-Awesome
  var fontAwesomeFonts = pickFiles('bower_components/components-font-awesome/fonts', {
      srcDir: '/',
    destDir: '/fonts'
  });

  // Typed
  app.import('bower_components/typed.js/js/typed.js');

  return mergeTrees([app.toTree(), fontAwesomeFonts, leafletAwesomeMarkers, leafletUserMarker]);
};