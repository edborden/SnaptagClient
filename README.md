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