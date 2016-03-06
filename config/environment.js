/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'stalkers-client',
    environment: environment,
    baseURL: '/',
    locationType: 'hash',
    apiHostName: 'http://localhost:3000',
    EmberENV: { FEATURES: {} },

    APP: {},

    torii: {
      sessionServiceName: 'session',
      providers: {
        'facebook-token': { apiKey: '726528350693125' }
      }
    },

  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
    ENV.keenProjectId = '56db25aa90e4bd3adbdeaef5';
    ENV.keenWriteKey = '7f2867f44b2612d9b6401e1ea809b92bfd08946f8701cecac92f2fbf03829b1e8c64e6743688c32486ad73ca425c97fd8fdb7d0c03f023aed67c8f7c57194538161af612dc088e5cfb5591ca766acc0bdfe7cc19b95d82f467b0e84edd9fd960';
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;
    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.apiHostName = 'https://damp-sea-6022.herokuapp.com'
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    ENV.APP.LOG_TRANSITIONS = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
    ENV.keenProjectId = '56db1aa2d2eaaa1bfc96deac';
    ENV.keenWriteKey = 'b764990fc74eccf73c7705cf3b4fb02274e5ac801715abc546c1d534c2d35744a5269746780dda77cc518760ff7910f7588725a9785da2569a3d5aed6772f4ac5316ee0e63d39090718debff3034cb40476b2e171915a94146130f0d50f8aafa';
  }

  return ENV;
};
