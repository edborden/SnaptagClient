AlertBarComponent = Ember.Component.extend(
	classNames: ['alert','alert-dismissable']
	classNameBindings: ['admin:alert-danger:alert-info',]
	admin: false
	)

`export default AlertBarComponent`