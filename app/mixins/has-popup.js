import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { notEmpty } from 'ember-computed-decorators';

const {
  Mixin,
  isPresent
} = Ember;

export default Mixin.create({

  @notEmpty('_popoverJqueryObject') _popoverOpen,

  // Set in template
  popoverContent: null,

  // Default behavior is for button to activate popover just one time, then send action on subsequent presses.
  justOnce: true,

  // Set after first popover closes if @once is set
  _noMorePopovers: false,

  // Action to send, set in template
  action: null,

  popoverPosition: 'top',

  // set in openPopover
  _jqueryObject: null,
  _popoverJqueryObject: null,

  showPopover() {
    let jq = this.$();
    this.set('_jqueryObject', jq);
    jq.popover({
      content: this.get('popoverContent'),
      placement: this.get('popoverPosition'),
      trigger: 'manual'
    }).popover('show');
    this.set('_popoverJqueryObject', jq.prop('nextSibling'));
    this.get('parentView').set('objectWithPopover', this);
  },

  removePopover() {
    this.get('_popoverJqueryObject').remove();
    this.set('_popoverJqueryObject', null);
    if (this.get('justOnce')) {
      this.set('_noMorePopovers', true);
    }
  },

  click() {
    if (isPresent(this.get('popoverContent'))) {
      this.removeAnyOpenPopover();
      if (!this.get('_popoverOpen')) {
        if (!this.get('_noMorePopovers')) {
          this.showPopover();
        } else {
          this.standardClick();
        }
      }
    } else {
      this.standardClick();
    }
  },

  standardClick() {
    switch (typeof this.get('action')) {
      case 'string':
        this.sendAction();
        break;
      case 'function':
        this.action();
        break;
    }
  },

  removeAnyOpenPopover() {
    let parentView = this.get('parentView');
    let objectWithPopover = parentView.get('objectWithPopover');
    if (isPresent(objectWithPopover)) {
      if (objectWithPopover.get('_popoverOpen')) {
        objectWithPopover.removePopover();
      }
      parentView.set('objectWithPopover', null);
    }
  }

});