import Ember from 'ember';
import { alias } from 'ember-computed-decorators';
import SnaptagMap from '../snaptag-map/component';
import layout from '../active-map/template';
const {
  inject: { service }
} = Ember;

export default SnaptagMap.extend({

  session: service(),

  @alias('session.me.zone') zone,

  layout,
  model: null

});