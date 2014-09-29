`import Resolver from 'ember/resolver'`
`import loadInitializers from 'ember/load-initializers'`

class App extends Ember.Application
	modulePrefix: 'appkit'
	Resolver: Resolver

loadInitializers(App, 'appkit')

`export default App`