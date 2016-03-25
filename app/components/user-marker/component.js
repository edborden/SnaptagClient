import computed from 'ember-computed-decorators';
import MarkerLayer from 'snaptag-client/components/marker-layer';

const UserMarker = L.Icon.extend({

  options: {
    iconSize: [65, 80],
    popupAnchor: [1, -90]
  },

  initialize(options) {
    options = L.Util.setOptions(this, options);
  },

  createIcon() {
    let div = document.createElement('div');
    div.className = 'user-marker';
    div.innerHTML = this._createInner();
    return div;
  },

  _createInner() {
    return `<img src=${this.options.imageUrl}>`;
  }

});

export default MarkerLayer.extend({

  // attributes
  icon: null,
  user: null,

  // computed
  @computed
  imageUrl() {
    let facebookid = this.get('user').get('facebookid');
    return `http://res.cloudinary.com/dtmsz8kse/image/facebook/w_45,h_45,c_thumb,g_face,r_max/${facebookid}.png`.htmlSafe();
  },

  // events
  init() {
    this._super();
    let imageUrl = this.get('imageUrl');
    let icon = new UserMarker({ imageUrl });
    this.set('icon', icon);
  },

  didCreateLayer() {
    // this._super(...arguments);
    if (this.get('hasBlock')) {
      this._popup = this.L.popup({}, this._layer);
      this._popup.setContent(this.get('destinationElement'));
      // register popup on leaflet layer so it can be accessed by spiderfier, don't want it to be called normally
      // this._layer.bindPopup(this._popup);
      this._layer._popup = this._popup;

      this._hijackPopup();

      this.popupOpenDidChange();
    }
  },

  willDestroyLayer() {
    // this._super(...arguments);
    if (this.get('hasBlock')) {
      // causing errors, handled by spiderfier anyway
      // this._layer.closePopup();
      // this._layer.unbindPopup();
      delete this._popup;
      delete this._firstNode;
      delete this._lastNode;
    }
  }

});