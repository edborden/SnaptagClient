Facebook = Ember.Mixin.create
  FBUser: undefined
  appId: undefined
  facebookParams: Ember.Object.create()
  fetchPicture: true
  build: false

  init: ->
    @_super()
    window.FBApp = this

  facebookConfigChanged: (->
    @removeObserver('appId')
    window.fbAsyncInit = => @fbAsyncInit()

    $ ->
      $('body').append($("<div>").attr('id', 'fb-root'))

      if build == true
        js = document.createElement 'script'

        $(js).attr
          id: 'facebook-jssdk'
          async: true
          src: "//connect.facebook.net/en_US/all.js"

        $('head').append js


  ).observes('facebookParams', 'appId')

  fbAsyncInit: ->
    facebookParams = @get('facebookParams')
    facebookParams = facebookParams.setProperties
      appId:  @get 'appId' || facebookParams.get('appId') || undefined
      status: facebookParams.get('status') || true
      cookie: facebookParams.get('cookie') || true
      xfbml: facebookParams.get('xfbml') || true
      channelUrl: facebookParams.get('channelUrl') || undefined

    FB.init facebookParams

    @set 'FBloading', true
    FB.Event.subscribe 'auth.authResponseChange', (response) => @updateFBUser(response)
    FB.getLoginStatus (response) => @updateFBUser(response)

  updateFBUser: (response) ->
    if response.status is 'connected'
      FB.api '/me', (user) =>
        FBUser = Ember.Object.create user
        FBUser.set 'accessToken', response.authResponse.accessToken
        FBUser.set 'expiresIn', response.authResponse.expiresIn

        if @get 'fetchPicture'
          FB.api '/me/picture', (resp) =>
            FBUser.picture = resp.data.url
            @set 'FBUser', FBUser
            @set 'FBloading', false
        else
          @set 'FBUser', FBUser
          @set 'FBloading', false
    else
      @set 'FBUser', false
      @set 'FBloading', false

Ember.FacebookView = Ember.View.extend
  classNameBindings: ['className']
  attributeBindings: []

  init: ->
    @_super()
    @setClassName()
    @attributeBindings.pushObjects(attr for attr of this when attr.match(/^data-/)?)

  setClassName: ->
    @set 'className', "fb-#{@type}"

  parse: ->
    FB.XFBML.parse @$().parent()[0].context if FB?

  didInsertElement: ->
    @parse()

`export default Facebook`