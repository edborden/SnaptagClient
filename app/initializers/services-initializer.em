initializer =

	initialize: (container,application) ->

		services = ['geolocation','notificator','session','realtime','growler','loader']

		#Inject into app factories
		['controller','route','adapter'].forEach (type) ->
			services.forEach (service) ->
				application.inject type, service, 'service:' + service

		#Setup service objects
		application.inject 'service:executive', 'map', 'controller:map'
		application.inject 'service:executive', 'router', 'router:main'
		application.inject 'service:loader', 'router', 'router:main'

`export default initializer`