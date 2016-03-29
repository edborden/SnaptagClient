import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias } from 'ember-computed-decorators';
import ScaledImage from '../scaled-image/component';

const {
  inject: { service }
} = Ember;

export default ScaledImage.extend({

  // services
  screen: service(),

  // attributes
  attributeBindings: [ 'style' ],
  classNameBindings: [ 'banner' ],
  user: null,
  face: false,
  style: null,
  banner: false,

  // computed
  @alias('user.facebookid') facebookid,

  @computed('facebookid')
  src() {
    let face = '';
    if (this.face) {
      face = 'g_face,';
    }
    let facebookid = this.get('facebookid');
    let sizePx = this.get('sizePx');
    return `https://res.cloudinary.com/dtmsz8kse/image/facebook/w_${sizePx},h_${sizePx},c_thumb,${face}r_max/${facebookid}.png`.htmlSafe();
  }

});