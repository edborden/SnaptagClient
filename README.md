Installation
============

Paths in 'grunt dist'
---------------------  

  In node_modules/grunt-usemin/lib/htmlprocessor.js, the following lines must be removed or js and css file paths will be incorrect in "grunt dist" build.

`if (block.startFromRoot) {
  dest = '/' + dest;
}`
Fonts
-----

  For font and image files from bootstrap or fontawesome to be included in "grunt dist" build:

` extrasToResult: {
  expand: true,
  cwd: 'vendor/fontawesome',
  src: 'fonts/*',
  dest: 'tmp/result/'
}

  extras2ToResult: {
    expand: true,
    cwd: 'vendor/leaflet.awesome-markers/dist',
    src: 'images/*',
    dest: 'tmp/result/'
  },`

  must be included in tasks/options/copy.js (before cssToResult) and registered

`_.merge(config, {
  concurrent: {
    buildDist: [
      "buildTemplates:dist",
      "buildScripts",
      "buildStyles",
      "buildExtras",
      "buildIndexHTML:dist"
    ],
    buildDebug: [
      "buildTemplates:debug",
      "buildScripts",
      "buildStyles",
      "buildExtras",
      "buildIndexHTML:debug"
    ]
  }
});

  grunt.registerTask('buildExtras', [
                     'copy:extrasToResult',
                     'copy:extras2ToResult'
                     ]);`
Config.xml
----------
Phonegap config.xml goes in public/

Facebook login
--------------
For facebook login to work during testing, callback.html must be served

`npm -g install simple-http-server`

from directory run
`nserver -p 4000`