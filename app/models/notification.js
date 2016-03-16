import DS from 'ember-data';

const {
  Model,
  attr,
  belongsTo
} = DS;

export default Model.extend({

  // attributes
  read: attr('boolean'),
  subject: attr('string'),
  body: attr('string'),
  createdAt: attr('string'),
  notifiedObjectType: attr('string'),
  notifiedObjectId: attr('number'),

  // associations
  hunt: belongsTo('hunt')

});