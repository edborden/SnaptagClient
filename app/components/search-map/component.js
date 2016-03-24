import SnaptagMap from '../snaptag-map/component';
import layout from '../search-map/template';
import NoLocation from '../../mixins/no-location';

export default SnaptagMap.extend(NoLocation, {

  layout,
  model: null

});