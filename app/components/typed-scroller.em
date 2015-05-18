class TypedScrollerComponent extends Ember.Component

	didInsertElement: ->	
		Ember.$(@element).typed
			strings: [@content]
			typeSpeed: 50

`export default TypedScrollerComponent`