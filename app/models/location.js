import computed from 'ember-computed-decorators';
import DS from 'ember-data';

const {
  Model,
  attr,
  belongsTo
} = DS;

export default Model.extend({

  // attributes
  lat: attr('number'),
  lng: attr('number'),
  createdAt: attr('string'),

  // associations
  user: belongsTo('user', { async: false })

});