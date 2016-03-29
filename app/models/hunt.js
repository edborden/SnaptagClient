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
  detail: attr('string')

});