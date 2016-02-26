import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias, equal } from 'ember-computed-decorators';

const {
  Component,
  isEqual,
  run: { later }
} = Ember;

export default Component.extend({

	// attributes
	tagName: 'h3',
	content: null,

	// computed
	@computed('content')
	typedContent() {
		let raw = this.get('content').split(' ');
		let typed = [];
		raw.forEach(function(item, index) {		
			// don't do this on the first element
			if (!isEqual(index, 0)) {
				typed.push(this.randomDelayString());
			}
			typed.push(item);
		});
		return typed.join(' ');
	},

	// events
	didInsertElement() {
		let onFinish = later(this, this.onFinish, 3000);	
		this.$().children().first().typed({
			strings: [ this.get('typedContent') ],
			typeSpeed: 50,
			callback: onFinish
		});
	},

	onFinish() {
		this.$().fadeOut(1500, () => {
			this.sendAction('action', this.get('content'));
		});
	},

	randomDelayString() {
		return '^' + this.getRandomInt(250, 550).toString();
	},

	getRandomInt(min, max) {
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

});