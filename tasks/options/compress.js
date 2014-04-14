module.exports = {
  compress: {
    options: {
      archive: 'dist/subrosadist.zip'
    },
    files: [
      {expand: true, cwd: 'dist/', src: ['**'], dest: '/'}, // makes all src relative to cwd
    ]
  }
};