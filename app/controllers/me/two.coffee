MeTwoController = Ember.ObjectController.extend(
	needs: "me"
	glyphicon1: Ember.computed.alias("controllers.me.glyphicon1")
	link1: Ember.computed.alias("controllers.me.link1")
	glyphicon2: Ember.computed.alias("controllers.me.glyphicon2")
	link2: Ember.computed.alias("controllers.me.link2")
	glyphicon3: Ember.computed.alias("controllers.me.glyphicon3")
	link3: Ember.computed.alias("controllers.me.link3")
	)
`export default MeTwoController`