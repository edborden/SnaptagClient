class TypedScrollerComponent extends Ember.Component

	tagName: 'h3'

	content: null

	typedContent: ~>
		raw = @content.split " "
		typed = []
		for item,index in raw		
			typed.push @randomDelayString() unless index is 0 #don't do this on the first element
			typed.push item
		typed.join " "

	didInsertElement: ->	
		Ember.$(@element).children().first().typed
			strings: [@typedContent]
			typeSpeed: 50
			callback: => Ember.run.later @, @onFinish, 3000

	onFinish: ->
		Ember.$(@element).fadeOut 1500, =>
			@sendAction 'action',@content

	randomDelayString: ->
		"^" + @getRandomInt(250,550).toString()

	getRandomInt: (min, max) ->
		Math.floor(Math.random() * (max - min + 1)) + min

`export default TypedScrollerComponent`