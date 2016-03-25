import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias } from 'ember-computed-decorators';

const {
  Component,
  inject: { service }
} = Ember;

export default Component.extend({

  // services
  screen: service(),

  // attributes
  tagName: 'img',
  attributeBindings: [ 'src', 'style' ],
  user: null,
  size: null,
  face: false,
  style: null,

  // computed
  @alias('user.facebookid') facebookid,

  @computed('screen.width')
  sizePx() {
    let sizePx = this.get('size') * (this.get('screen').get('width') / 100);
    return Math.round(sizePx);
  },

  @computed('facebookid')
  src() {
    let face = '';
    if (this.face) {
      face = 'g_face,';
    }
    let facebookid = this.get('facebookid');
    let sizePx = this.get('sizePx');
    return `http://res.cloudinary.com/dtmsz8kse/image/facebook/w_${sizePx},h_${sizePx},c_thumb,${face}r_max/${facebookid}.png`.htmlSafe();
  }

});