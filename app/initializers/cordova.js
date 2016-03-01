import config from 'stalkers-client/config/environment';

export function initialize() {
			
		if (config.environment === 'production') {
			document.addEventListener('deviceready', function() {
				document.addEventListener('backbutton', function() {
          navigator.app.exitApp();
        });
      });
			$.getScript('phonegap.js');    
    }

};

export default {
  name: 'cordova',
  initialize
};