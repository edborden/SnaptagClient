import { configurable } from 'torii/configuration';
import Oauth2 from 'torii/providers/oauth2-bearer';

export default Oauth2.extend({

	name:    'facebook-token',
	baseUrl: 'https://www.facebook.com/dialog/oauth',

	requiredUrlParams: ['display'],

	responseParams: ['token'],

	scope:        configurable('scope', 'email'),

	display: 'popup'

});