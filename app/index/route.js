import Ember from 'ember';
import ChecksStatus from '../mixins/checks-status';
import StartsTransmit from '../mixins/starts-transmit';

const {
  Route
} = Ember;

export default Route.extend(ChecksStatus, StartsTransmit);