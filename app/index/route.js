import Ember from 'ember';
import ChecksStatus from '../mixins/checks-status';
import StartsTransmit from '../mixins/starts-transmit';
import KeenRoute from '../mixins/keen-route';

const {
  Route
} = Ember;

export default Route.extend(ChecksStatus, StartsTransmit, KeenRoute);