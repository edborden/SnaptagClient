import { ActiveModelSerializer } from 'active-model-adapter';

ActiveModelSerializer.reopen({ isNewSerializerAPI: true });

export default ActiveModelSerializer.extend();