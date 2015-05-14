/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'stalkers-client',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    apiHostName: 'http://localhost:3000',
    EmberENV: { FEATURES: {} },

    APP: {},

    torii: {
      sessionServiceName: 'session',
      providers: {
        'facebook-token': {
        apiKey:'726528350693125'
        }
      }
    },

  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
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

  if (environment === 'production' || environment === 'phonegap') {
    ENV.apiHostName = 'http://damp-sea-6022.herokuapp.com'
  }

  return ENV;
};
