import Ember from 'ember';
import computed from 'ember-computed-decorators';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  // services
  screen: service(),

  // attributes
  tagName: 'img',
  attributeBindings: [ 'src' ],
  size: null,
  max: false,
  imageId: null,

  // computed

  @computed('screen.width')
  sizePx() {
    let screenWidth = this.get('screen').get('width');
    let sizePx;
    if (this.max) {
      sizePx = screenWidth;
    } else {
      sizePx = this.size * (screenWidth / 100);
    }
    return Math.round(sizePx);
  },

  @computed
  src() {
    let imageId = this.imageId;
    let sizePx = this.get('sizePx');
    return `https://res.cloudinary.com/dtmsz8kse/image/upload/c_limit,w_${sizePx},h_${sizePx}/${imageId}.jpg`
  }

});