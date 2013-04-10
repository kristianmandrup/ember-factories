Ember.applicationClass = App

Ember.factory = Ember.Object.extend
  init: (type) ->
    # get model class from camelized type name
    @type = Ember.camelize(type)  

  properties: (hash)
    @hash = hash
    # register factory
    Ember.factories.register(@)
    @

  setup: ->
    @type = Ember.applicationClass[@type]
    for key, value in @hash 
      @type[key] = _resolveValue(value)
    @type

  _resolveValue: (value) ->
    case Ember.typeOf(value)
    when 'function'
      value.call
    else
      value

Ember.factories = Ember.Map.extend
  register: (factory) ->
    @set factory.type, factory
  find: (type) ->
    @get Ember.camelize(type)

Ember.factory_for = (type) ->
  Ember.factories.find(type).setup
