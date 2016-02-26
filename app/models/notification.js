import computed from 'ember-computed-decorators';
import DS from 'ember-data';

const {
  Model,
  attr
} = DS;

export default Model.extend({

  // attributes
  read: attr('boolean'),
  subject: attr('string'),
  body: attr('string'),
  createdAt: attr('string'),
  notifiedObjectType: attr('string'),
  notifiedObjectId: attr('number'),

  // computed
  @computed
  createdAtFormatted() {
    return moment(this.get('createdAt')).fromNow();
  }
});