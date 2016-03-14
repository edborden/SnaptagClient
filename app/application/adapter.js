import ActiveModelAdapter from 'active-model-adapter';
import RequestsConfig from '../mixins/requests-config';

export default ActiveModelAdapter.extend(RequestsConfig, {

  // crossdomain
  ajax(url, method, hash) {
    hash = hash || {};
    hash.crossDomain = true;
    return this._super(url, method, hash);
  }

});