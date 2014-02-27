WorldOneController = Ember.ObjectController.extend(
	needs: "world"
	glyphicon1: Ember.computed.alias("controllers.world.glyphicon1")
	link1: Ember.computed.alias("controllers.world.link1")
	glyphicon2: Ember.computed.alias("controllers.world.glyphicon2")
	link2: Ember.computed.alias("controllers.world.link2")
	glyphicon3: Ember.computed.alias("controllers.world.glyphicon3")
	link3: Ember.computed.alias("controllers.world.link3")
	)
`export default WorldOneController`