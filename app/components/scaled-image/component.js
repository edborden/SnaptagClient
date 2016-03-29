import Ember from 'ember';
import computed from 'ember-computed-decorators';
import AutoCloser from '../auto-closer/component';

const {
  inject: { service }
} = Ember;

export default AutoCloser.extend({

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
    let sizePx = this.size * (screenWidth / 100);
    return Math.round(sizePx);
  },

  @computed
  src() {
    let { imageId } = this;
    let sizePx = this.get('sizePx');
    let widthPx;
    let heightPx;
    if (this.max) {
      let screen = this.get('screen');
      heightPx = screen.get('height');
      widthPx = screen.get('width');
    } else {
      sizePx = this.get('sizePx');
      heightPx = sizePx;
      widthPx = sizePx;
    }
    return `https://res.cloudinary.com/dtmsz8kse/image/upload/c_limit,w_${widthPx},h_${heightPx}/${imageId}.jpg`;
  }

});