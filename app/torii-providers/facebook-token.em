`import {configurable} from 'torii/configuration'`
`import Oauth2 from 'torii/providers/oauth2-bearer'`

class FacebookToken extends Oauth2
	name:    'facebook-token'
	baseUrl: 'https://www.facebook.com/dialog/oauth'

	requiredUrlParams: ['display']

	responseParams: ['token']

	scope:        configurable('scope', 'email')

	display: 'popup'

`export default FacebookToken`