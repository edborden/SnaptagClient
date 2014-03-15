Facebook = Ember.Mixin.create
  appId: undefined
  test: true

  facebookInit: (->
    @removeObserver('appId')
    
    $ ->
      $('body').append($("<div>").attr('id', 'fb-root'))

    if @get 'test'
      $ ->
        js = document.createElement 'script'
        $(js).attr
          id: 'facebook-jssdk'
          async: true
          src: "//connect.facebook.net/en_US/all.js"
        $('head').append js
      window.fbAsyncInit = => @fbAsyncInit()
    else
      document.addEventListener('deviceready',@fbAsyncInit())

  ).observes('appId')

  fbAsyncInit: ->
    FB.init(
      appId: @get 'appId'
      status: false
    )

    FB.Event.subscribe 'auth.authResponseChange', (response) => console.log "authchange"
    FB.getLoginStatus (response) => console.log "getloginstatus"

`export default Facebook`