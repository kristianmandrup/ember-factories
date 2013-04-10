Number::times = (fn) ->
  do fn for [1..@valueOf()]
  return

Ember.applicationClass = App

Ember.Factory = Ember.Object.extend
  init: (type) ->
    # get model class from camelized type name
    @type = type.camelize()

  properties: (hash)
    @hash = hash
    # register factory
    Ember.factories.register(@)
    @

  setup: (index) ->
    # create empty model instance
    @type = _modelClass().create

    # set model attributes using factory properties
    for key, value in @hash 
      @type.set key, _resolveValue(value, index)
    # finally return model instance setup using factory :)
    @type.f = @
    @type

  build: (count = 1) ->
    [1..count].map(index) ->
      setup(index)

  f: Ember.Factory

  # TODO: How to improve this!? 
  _modelClass: ->
    Ember.applicationClass[@type]

  _resolveValue: (value, index) ->
    switch Ember.typeOf(value)
    when 'function'
      # lazy evaluated factory value :)
      value.call(index)
    else
      value

Ember.Factory.reopenClass
  counter: (type) ->
    @counter_hash ||= {}
    counter = @counter_hash[type] ||= 0
    counter += 1

# Map of registered factories!
Ember.Factories = Ember.Map.extend
  register: (factory) ->
    @set factory.type, factory
  find: (type) ->
    @get type.camelize()

Ember.factories = Ember.Factories.create

Ember.factory_for = (type) ->
  Ember.factories.find(type).setup

Ember.factories_for = (type, count = 1) ->
  Ember.factories.find(type).setup count
