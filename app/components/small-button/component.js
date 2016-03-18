import Ember from 'ember';
import computed from 'ember-computed-decorators';
import Rotatable from '../../mixins/rotatable';
import HasPopup from '../../mixins/has-popup';

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
  base: 78,

  // computed
  @computed
  circleDim() {
    let vw = this.get('vw');
    return 10 * vw / 2;
  },

  @computed
  panelDim() {
    let vw = this.get('vw');
    let base = this.get('base');
    if (this.get('inside')) {
      return base * vw / 4;
    } else {
      return base * vw / 2;
    }
  }

});