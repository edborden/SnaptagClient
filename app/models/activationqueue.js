import DS from 'ember-data';
const {
  Model,
  attr,
  belongsTo
} = DS;

export default Model.extend({

  usersCount: attr('number'),
  zone: belongsTo('zone', { async: false })

});