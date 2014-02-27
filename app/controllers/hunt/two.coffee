HuntTwoController = Ember.ObjectController.extend(
	needs: "hunt"
	glyphicon1: Ember.computed.alias("controllers.hunt.glyphicon1")
	link1: Ember.computed.alias("controllers.hunt.link1")
	glyphicon2: Ember.computed.alias("controllers.hunt.glyphicon2")
	link2: Ember.computed.alias("controllers.hunt.link2")
	glyphicon3: Ember.computed.alias("controllers.hunt.glyphicon3")
	link3: Ember.computed.alias("controllers.hunt.link3")
	)
`export default HuntTwoController`