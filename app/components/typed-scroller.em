class TypedScrollerComponent extends Ember.Component

	classNames: ['stalkers']

	didInsertElement: ->	
		Ember.$(@element).typed
			strings: [@content]
			typeSpeed: 50

`export default TypedScrollerComponent`