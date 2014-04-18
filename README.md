Installation
============

Paths in 'grunt dist'
---------------------  

  In node_modules/grunt-usemin/lib/htmlprocessor.js, the following lines must be removed or js and css file paths will be incorrect in "grunt dist" build.

`
  if (block.startFromRoot) {
    dest = '/' + dest;
  }
`
Fonts
-----

  For font files from bootstrap or fontawesome to be included in "grunt dist" build:

`
    extrasToResult: {
    expand: true,
    cwd: 'vendor/fontawesome',
    src: 'fonts/*',
    dest: 'tmp/result/'
  }
`

  must be included in tasks/options/copy.js (before cssToResult) and registered

`
    // Parallelize most of the build process
  _.merge(config, {
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

    // Extras
  grunt.registerTask('buildExtras', [
                     'copy:extrasToResult'
                     ]);
`
Config.xml
----------
Phonegap config.xml goes in public/

Facebook login
--------------
For facebook login to work during testing, callback.html must be served

`
npm -g install simple-http-server
`
from directory run
`
nserver -p 4000
`