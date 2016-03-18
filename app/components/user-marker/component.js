import MarkerLayer from 'snaptag-client/components/marker-layer';
import computed from 'ember-computed-decorators';

const UserMarker = L.Icon.extend({

  options: {
      iconSize: [65, 80],
      popupAnchor: [1, -90]
  },

  initialize(options) {
      options = L.Util.setOptions(this, options);
  },

  createIcon() {
      var div = document.createElement('div');
      div.className = 'user-marker';

      div.innerHTML = this._createInner();

      return div;
  },

  _createInner() {
    return `<img class='tiny' src=${this.options.imageUrl}>`;
  }

});

export default MarkerLayer.extend({

  imageUrl: null,
  icon: null,

  init() {
    this._super();
    let imageUrl = this.get('imageUrl');
    let icon = new UserMarker({
      imageUrl: this.get('imageUrl')
    });
    this.set('icon', icon);
  }

});