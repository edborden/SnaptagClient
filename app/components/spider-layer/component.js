import Ember from 'ember';
import BaseLayer from 'ember-leaflet/components/base-layer';
import ContainerMixin from 'ember-leaflet/mixins/container';
import { alias } from 'ember-computed-decorators';

export default BaseLayer.extend(ContainerMixin, {

  // attributes
  options: {
    keepSpiderfied: true,
    legWeight: 5,
    circleFootSeparation: 50
  },

  // computed
  @alias('containerLayer._layer') map,

  // events
  createLayer() {
    let map = this.get('map');
    let oms = new OverlappingMarkerSpiderfier(map, this.get('options'));
    let omsAddLayer = Ember.run.bind(this, this.omsAddLayer);
    oms.addLayer = omsAddLayer;
    let omsRemoveLayer = Ember.run.bind(this, this.omsRemoveLayer);
    oms.removeLayer = omsRemoveLayer;
    oms.addListener('click', function(marker) {
      marker.bindPopup(marker._popup);
      marker.openPopup();
    });
    oms.addListener('spiderfy', function(markers) {
      map.closePopup();
    });
    return oms;
  },

  layerTeardown() {
    this.get('map').closePopup();
    this.get('_childLayers').invoke('layerTeardown');
    this.get('_childLayers').clear();
  },

  layerSetup() {
    this._layer = this.createLayer();
    this.get('_childLayers').invoke('layerSetup');
  },

  // helpers
  omsAddLayer(childLayer) {
    this._layer.addMarker(childLayer);
    this.get('containerLayer')._layer.addLayer(childLayer);
  },

  omsRemoveLayer(childLayer) {
    this._layer.removeMarker(childLayer);
    this.get('containerLayer')._layer.removeLayer(childLayer);
  }

});