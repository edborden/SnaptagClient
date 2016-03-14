import AjaxService from 'ember-ajax/services/ajax';
import RequestsConfig from '../mixins/requests-config';

export default AjaxService.extend(RequestsConfig, {

  request(url, options) {
    return this._super(url, this._addCrossDomainToOptions(options));
  },

  getServer(url, data) {
    return this.request(url, { data });
  },

  _addCrossDomainToOptions(options) {
    options = options || {};
    options.crossDomain = true;
    return options;
  }

});