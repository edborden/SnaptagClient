class ScoreListView extends Ember.View
	template: Ember.Handlebars.compile "{{exposedCount}} / {{counteractCount}} / {{disavowedCount}} / {{compromisedCount}}"
	click: -> Ember.$(@element).popover {content:"Current score: Exposed / Counteracts / Disavowed / Compromised",placement:'top'}
	tagName: 'span'

`export default ScoreListView`