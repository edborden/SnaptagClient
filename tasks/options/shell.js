module.exports = {
	'git': {
		command: "git add -A && git commit -m 'auto' && git push",
		options: {
			stdout: true,
			execOptions: {cwd: 'dist'}
		}
	}
};