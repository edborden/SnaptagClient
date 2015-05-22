class TypedScrollerComponent extends Ember.Component

	content: null

	typedContent: ~>
		raw = @content.split " "
		typed = []
		for item,index in raw		
			typed.push @randomDelayString() unless index is 0 #don't do this on the first element
			typed.push item
		typed.join " "

	classNames: ['stalkers']

	didInsertElement: ->	
		Ember.$(@element).children().first().typed
			strings: [@typedContent]
			typeSpeed: 50

	randomDelayString: ->
		"^" + @getRandomInt(250,550).toString()

	getRandomInt: (min, max) ->
		Math.floor(Math.random() * (max - min + 1)) + min

`export default TypedScrollerComponent`