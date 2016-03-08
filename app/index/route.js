import Ember from 'ember';
import ChecksStatus from 'stalkers-client/mixins/checks-status';

const {
  Route
} = Ember;

export default Route.extend(ChecksStatus, {});