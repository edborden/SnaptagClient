/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

require('broccoli-ember-script')(app.toTree())

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

var pickFiles = require('broccoli-static-compiler');
var mergeTrees = require('broccoli-merge-trees');

// Bootstrap Popover
app.import('bower_components/bootstrap/js/tooltip.js');
app.import('bower_components/bootstrap/js/popover.js');

// Pusher
app.import('bower_components/pusher/dist/pusher.min.js');

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

module.exports = mergeTrees([app.toTree(), fontAwesomeFonts, leafletAwesomeMarkers, leafletUserMarker]);