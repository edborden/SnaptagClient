import Ember from 'ember';
import ChecksStatus from '../mixins/checks-status';
import KeenRoute from '../mixins/keen-route';

const {
  Route
} = Ember;

export default Route.extend(ChecksStatus, KeenRoute);