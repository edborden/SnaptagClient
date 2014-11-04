HasPopup = new Ember.Mixin
	
	popup: null

	popover: null

	click: ->
		if @popup
			if @popover
				Ember.$(".popover").remove()
				#@popover = false
				#popup only appears one time on purpose, so that tooltips can be displayed on buttons that might need an action explained
			else
				Ember.$(".popover").remove()
				Ember.$(@element).popover({content:@popup,placement:'top'}).popover 'show'
				@popover = true

`export default HasPopup`