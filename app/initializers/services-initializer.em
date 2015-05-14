`import GeolocationService from 'stalkers-client/services/geolocation'`
`import SessionService from 'stalkers-client/services/session'`
`import TransmitService from 'stalkers-client/services/transmit'`
`import RealtimeService from 'stalkers-client/services/realtime'`

initializer =
	name:'services'
	after: 'store'
	initialize: (container,application) ->

		#Register service objects
		application.register 'service:session', SessionService
		application.register 'service:geolocation', GeolocationService
		application.register 'service:transmit', TransmitService
		application.register 'service:realtime', RealtimeService
		services = ['session','geolocation']

		#Inject into app factories
		['controller','route','adapter'].forEach (type) ->
			services.forEach (service) ->
				application.inject type, service, 'service:' + service

		#Setup service objects
		application.inject 'service:realtime', 'map', 'controller:map'

`export default initializer`