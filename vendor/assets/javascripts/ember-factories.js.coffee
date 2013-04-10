Ember.applicationClass = App

Ember.factory = Ember.Object.extend
  init: (type) ->
    # get model class from camelized type name
    @type = type.camelize()

  properties: (hash)
    @hash = hash
    # register factory
    Ember.factories.register(@)
    @

  setup: ->
    # create empty model instance
    @type = _modelClass().create

    # set model attributes using factory properties
    for key, value in @hash 
      @type.set key, _resolveValue(value)
    # finally return model instance setup using factory :)
    @type

  # TODO: How to improve this!? 
  _modelClass: ->
    Ember.applicationClass[@type]

  _resolveValue: (value) ->
    switch Ember.typeOf(value)
    when 'function'
      # lazy evaluated factory value :)
      value.call()
    else
      value

# Map of registered factories!
Ember.factories = Ember.Map.extend
  register: (factory) ->
    @set factory.type, factory
  find: (type) ->
    @get type.camelize()

Ember.factory_for = (type) ->
  Ember.factories.find(type).setup
