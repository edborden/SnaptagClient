`import GeolocationService from 'stalkers-client/services/geolocation'`
`import SessionService from 'stalkers-client/services/session'`
`import TransmitService from 'stalkers-client/services/transmit'`
`import RealtimeService from 'stalkers-client/services/realtime'`
`import GrowlerService from 'stalkers-client/services/growler'`
`import NotificatorService from 'stalkers-client/services/notificator'`
`import ExecutiveService from 'stalkers-client/services/executive'`
`import RegistratorService from 'stalkers-client/services/registrator'`

initializer =
	name:'services'
	after: 'store'
	initialize: (container,application) ->

		#Register service objects
		application.register 'service:registrator', RegistratorService
		application.register 'service:session', SessionService
		application.register 'service:geolocation', GeolocationService
		application.register 'service:transmit', TransmitService
		application.register 'service:realtime', RealtimeService
		application.register 'service:growler', GrowlerService
		application.register 'service:notificator', NotificatorService
		application.register 'service:executive', ExecutiveService

		services = ['session','geolocation','realtime','registrator']

		#Inject into app factories
		['controller','route','adapter'].forEach (type) ->
			services.forEach (service) ->
				application.inject type, service, 'service:' + service

		#Setup service objects
		application.inject 'service:executive', 'map', 'controller:map'
		application.inject 'service:executive', 'router', 'router:main'

`export default initializer`