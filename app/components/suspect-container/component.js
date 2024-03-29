import Ember from 'ember';
import computed from 'ember-computed-decorators';
import { alias, equal } from 'ember-computed-decorators';
import Rotatable from '../../mixins/rotatable';

const {
  Component,
  inject: { service },
  isEqual
} = Ember;

export default Component.extend(Rotatable, {

  // services
  session: service(),

  // attributes
  classNameBindings: [ 'target' ],
  suspect: null,
  activeSuspect: null,

  // computed
  @alias('suspect.isTarget') target,
  @alias('session.me.suspects.length') totalCount,

  @computed('activeSuspect')
  active() {
    return isEqual(this.get('activeSuspect'), this.get('suspect'));
  },

  @computed
  panelDim() {
    let vw = this.get('vw');
    return 78 * vw / 2;
  },

  @computed
  circleDim() {
    let vw = this.get('vw');
    return 19 * vw / 2;
  }

});