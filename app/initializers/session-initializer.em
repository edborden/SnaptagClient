`import Session from 'appkit/lib/session'`

initializer =
	name:'session'
	after: 'store'
	initialize: (container,application) ->
		application.register 'session:current', Session, {singleton: true}
		application.inject 'session:current', 'store', 'store:main'
		application.inject 'controller', 'session', 'session:current'
		application.inject 'route', 'session', 'session:current'
		application.inject 'adapter:application', 'session', 'session:current'

`export default initializer`