ContentFade = new Ember.Mixin
	
	didInsertElement: ->
		@.$().hide()
		@element.style.opacity = 1
		@.$().fadeIn(200)

`export default ContentFade`