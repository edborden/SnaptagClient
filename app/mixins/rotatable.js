import Ember from 'ember';
import computed from 'ember-computed-decorators';

const {
  Mixin
} = Ember;

export default Mixin.create({

  // attributes
  attributeBindings: ['style'],
  vw: null,

  // computed
  @computed('totalCount', 'contentIndex')
  rotateBy() {
    return 360 / this.get('totalCount') * this.get('contentIndex');
  },

  @computed('rotateBy')
  style() {
    return `-webkit-transform:rotate(${this.get('rotateBy')}deg);`.htmlSafe();
  },

  @computed('rotateBy')
  innerStyle() {
    return `-webkit-transform:rotate(${this.get('rotateBy') * -1}deg);`.htmlSafe();
  },

  // events
  didInsertElement() {
    this._super();
    let vw = Ember.$('body').width() / 100;
    this.set('vw', vw);
    let origin = this.get('panelDim') + this.get('circleDim');
    this.get('element').style.webkitTransformOrigin = `50%${origin}px`;
  }
});