import Ember from 'ember';
import RequiresLocation from '../mixins/requires-location';
import StartsTransmit from '../mixins/starts-transmit';

const {
  Route
} = Ember;

export default Route.extend(RequiresLocation, StartsTransmit);