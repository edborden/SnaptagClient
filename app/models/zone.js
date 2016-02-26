import DS from 'ember-data';

const {
  Model,
  attr,
  hasMany
} = DS;

export default Model.extend({

  // attributes
  lat: attr('number'),
  lng: attr('number'),
  range: attr('number'),
  active: attr('boolean'),

  // associations
  users: hasMany('user', { async: false })

});