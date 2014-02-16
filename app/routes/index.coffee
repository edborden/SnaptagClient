IndexRoute = Ember.Route.extend(
  model: ->
    this.store.find('user', 'two')
)

`export default IndexRoute`
