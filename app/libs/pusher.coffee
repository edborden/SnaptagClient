Pusher = Ember.Object.extend(
  key: '920f77cedd553842882b'

  init: ->
    _this = this
    this.service = new Pusher(this.get("key"))

    this.service.connection.bind('connected', -> _this.connected())
    this.service.bind_all( (eventName, data) -> _this.handleEvent(eventName, data) )

  connected: ->
    this.socketId = this.service.connection.socket_id
    this.addSocketIdToXHR()

  # add X-Pusher-Socket header so we can exclude the sender from their own actions
  # http://pusher.com/docs/server_api_guide/server_excluding_recipients
  addSocketIdToXHR: ->
    _this = this
    Ember.$.ajaxPrefilter( (options, originalOptions, xhr) ->
      xhr.setRequestHeader('X-Pusher-Socket', _this.socketId)
    )

  subscribe: (channel) ->
    this.service.subscribe(channel)

  unsubscribe: (channel) ->
    this.service.unsubscribe(channel)

  handleEvent: (eventName, data) ->

    # ignore pusher internal events
    if eventName.match(/^pusher:/) 
      return

    router = this.get("container").lookup("router:main")
    try
      router.send(eventName, data)
    catch e
      unhandled = e.message.match(/Nothing handled the event/)
      if !unhandled 
        throw e
)

`export default Pusher`