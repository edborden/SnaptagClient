module.exports = {
  compile: {
    files: [{
      expand: true,
      cwd: 'app/styles',
      src: ['app.less', '!**/_*.less'],
      dest: 'tmp/result/assets/',
      ext: '.css'
    }]
  }
};
