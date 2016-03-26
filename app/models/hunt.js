import computed from 'ember-computed-decorators';
import DS from 'ember-data';

const {
  Model,
  attr
} = DS;

export default Model.extend({

  // attributes
  lat: attr('number'),
  lng: attr('number'),
  completedAt: attr('string'),
  imageId: attr('string'),
  detail: attr('string'),

  // computed
  @computed
  msrc() {
    return `https://res.cloudinary.com/dtmsz8kse/image/upload/c_limit,w_250,h_100/${this.get('imageId')}.jpg`;
  },

  @computed
  src() {
    return `https://res.cloudinary.com/dtmsz8kse/image/upload/${this.get('imageId')}.jpg`;
  }

});