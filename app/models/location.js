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
  user: belongsTo('user', { async: false }),

  // computed
  @computed
  location() {
    return L.latLng(this.get('lat'), this.get('lng'));
  },

  @computed
  popupContent() {
    let name = this.get('user').get('name')
    let fromNow = moment(this.get('createdAt')).fromNow()
    return name + ", " + fromNow;
  }
});