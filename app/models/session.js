import DS from 'ember-data';

const {
  Model,
  attr,
  belongsTo
} = DS;

export default Model.extend({

  // attributes
  token: attr('string'),
  regId: attr('string'),
  platform: attr('string'),

  // associations
  user: belongsTo('user', { async: false })

});