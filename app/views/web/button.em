class WebButtonView extends Ember.View
	classNames: ['web-button']
	template: Ember.Handlebars.compile "<i class='fa fa-eye fa-2x'></i>"
	click: -> @parentView.toggleProperty 'showWeb'
	classNameBindings: ['parentView.showWeb:active']

`export default WebButtonView`