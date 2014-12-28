`import LocService from 'stalkers-client/services/loc'`
`import SessionService from 'stalkers-client/services/session'`
`import TransmitService from 'stalkers-client/services/transmit'`
`import RealtimeService from 'stalkers-client/services/realtime'`

initializer =
	name:'services'
	after: 'store'
	initialize: (container,application) ->

		#Register service objects
		application.register 'service:loc', LocService, {singleton: true}
		application.register 'service:session', SessionService, {singleton: true}
		application.register 'service:transmit', TransmitService, {singleton: true}
		application.register 'service:realtime', RealtimeService, {singleton: true}

		#Setup service objects
		['session','transmit','realtime'].forEach (type) ->
			application.inject 'service:' + type, 'store', 'store:main'
		application.inject 'service:realtime', 'map', 'controller:map'

		#Inject session
		application.inject 'service:transmit', 'session', 'service:session'
		application.inject 'service:realtime', 'session', 'service:session'

		#Inject into app factories
		['controller','route','model'].forEach (type) ->
			application.inject type, 'loc', 'service:loc'

		['controller','route','model','adapter'].forEach (type) ->
			application.inject type, 'session', 'service:session'

`export default initializer`