Installation
============

Paths in 'grunt dist'
---------------------  

  In node_modules/grunt-usemin/lib/htmlprocessor.js, the following lines must be removed or js and css file paths will be incorrect in "grunt dist" build.

`if (block.startFromRoot) {
  dest = '/' + dest;
}`

Config.xml
----------
Phonegap config.xml goes in public/

Facebook login
--------------
For facebook login to work during testing, callback.html must be served

`npm -g install simple-http-server`

from directory run
`nserver -p 4000`

For npm on Windows
------------------
node gyp won't work without following dependencies
- Python 2.7
- Visual Studio 2013 Express
- possible gyp manual update (https://github.com/TooTallNate/node-gyp/issues/339)

To disable CORS for development on local machine and remote server
------------------
https://chrome.google.com/webstore/detail/allow-control-allow-origi/nlfbmbojpeacfghkpbjhddihlkkiljbi