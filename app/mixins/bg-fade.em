BgFade = new Ember.Mixin
	
	didInsertElement: ->
		@.$().hide()
		@element.style.opacity = ".65"
		@.$().fadeIn(200)

`export default BgFade`