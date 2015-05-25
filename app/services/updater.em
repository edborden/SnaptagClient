class UpdaterService extends Ember.Service

	store: Ember.inject.service()

	appVersion: 2
	updateApp: false

	iosLink: "http://itunes.apple.com/app/id998182913"
	androidLink: "market://details?id=com.stalkersgame"

	updateLink: ~> 
		if @androidDevice() then @androidLink else @iosLink

	checkUpdate: ->
		return new Ember.RSVP.Promise (resolve) =>
			@store.find('version').then( 
				(versions) =>
					if device?
						if @androidDevice()
							remoteVersion = versions.filterBy('platform','android').firstObject.revision
						else
							remoteVersion = versions.filterBy('platform','ios').firstObject.revision
						localVersion = @appVersion
						@updateApp = true if remoteVersion > localVersion
					resolve @updateApp
			)

	androidDevice: -> device.platform is 'android' or device.platform is 'Android'


`export default UpdaterService`