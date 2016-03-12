import Ember from 'ember';
import computed from 'ember-computed-decorators';
import Rotatable from 'stalkers-client/mixins/rotatable';
import HasPopup from 'stalkers-client/mixins/has-popup';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend(Rotatable, HasPopup, {

  // attributes
  classNameBindings: [ 'inside' ],
  totalCount: 16,
  content: null,
  overlayContent: null,

  // computed
  @computed
  circleDim() {
    let vw = this.get('vw');
    return 10 * vw / 2;
  },

  @computed
  panelDim() {
    let vw = this.get('vw');
    if (this.get('inside')) {
      return 78 * vw / 4;
    } else {
      return 78 * vw / 2;
    }
  }

});