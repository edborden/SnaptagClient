import Ember from 'ember';
import BaseLayer from 'ember-leaflet/components/base-layer';
import ContainerMixin from 'ember-leaflet/mixins/container';

export default BaseLayer.extend(ContainerMixin, {

  createLayer() {
    let map = this.get('containerLayer')._layer;
    let oms = new OverlappingMarkerSpiderfier(map);
    let omsAddLayer = Ember.run.bind(this, this.omsAddLayer);
    oms['addLayer'] = omsAddLayer;
    oms.addListener('click', function(marker) {
      marker.bindPopup(marker._popup);
      marker.openPopup();
    });
    return oms;
  },

  willDestroyLayer() {
    this.get('_childLayers').invoke('layerTeardown');
    this.get('_childLayers').clear();
  },

  layerSetup() {
    if (Ember.isNone(this.get('_layer'))) {
      this._layer = this.createLayer();
      this._addObservers();
      this._addEventListeners();
      this.didCreateLayer();
    }
    this.get('_childLayers').invoke('layerSetup');
  },

  omsAddLayer(childLayer) {
    this._layer.addMarker(childLayer);
    this.get('containerLayer')._layer.addLayer(childLayer);
  }

});