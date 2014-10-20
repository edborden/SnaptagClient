class ScoreListView extends Ember.View

	didInsertElement:->
		Ember.$(@element).popover {content:"Current score: Exposed / Counteracts / Disavowed / Compromised",placement:'top'}

	template: Ember.Handlebars.compile "{{exposedCount}} / {{counteractCount}} / {{disavowedCount}} / {{compromisedCount}}"

	tagName: 'span'

`export default ScoreListView`