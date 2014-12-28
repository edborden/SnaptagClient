`import { test, moduleFor } from 'ember-qunit'`

moduleFor 'service:realtime',"Unit - RealTime"

test "it works", ->
	ok @subject().status is null