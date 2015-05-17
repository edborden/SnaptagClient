module.exports = function(grunt) {

grunt.initConfig({
	shell: {
		build: {
			command: "ember build --environment=production"
		},
		git: {
			command: "git init && git remote add origin git@github.com:edborden/StalkersClientBuild.git && git add -A && git commit -m 'auto'",
			options: {
				stdout: true,
				execOptions: {cwd: 'dist'}
			}
		}//,
		//push: {
		//	command: "git push origin master",
		//	options: {
		//		stdout: true,
		//		execOptions: {cwd: 'dist'}
		//	}
		//}		
	},
	"phonegap-build": {
		"deploy": {
			"options": {
				"appId": "1299338",
				"user": {"token": "uqr4zBN24LtPxQRgr38D"},
				"isRepository":"true",
				"archive":""
			}
		}
	}
});

grunt.loadNpmTasks('grunt-shell');
grunt.loadNpmTasks('grunt-phonegap-build');

grunt.registerTask('default', ['shell','phonegap-build']);

};