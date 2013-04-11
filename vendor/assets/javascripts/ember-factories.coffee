Ember.Factory = Ember.Object.extend
  init: () ->
    # get model class from camelized type name
    type = @get('type').classify()
    
    throw "You must specify the type to create:- create(type: 'person)" unless type

    @set 'type', type.classify()

    @set 'store', Ember.factories.store()

    props = this.get('properties')
    @properties(props) if props

    @


  properties: (hash) ->
    @hash = hash
    # register factory
    Ember.factories.register(@)
    @

  setup: (index) ->
    # create empty model instance
    type = @get('type')

    clazz = @_modelClass(type)

    throw "Model class for " + type + ' can not be resolved :(' unless clazz

    # console.log 'setup for class:', clazz

    # define model properties using factory properties
    props = {}
    for key, value in @hash 
      props[key] = @_resolveValue(value, index)

    # set property that indicate this model obj was built by a factory
    props.factory_built = true

    # set f to point to the factory that created the model
    props.f = @  

    # finally create Model in store and return it!    

    throw "You must use Ember.factories.use_store(store) to set the store to be used by factories" unless store

    # console.log "Creating:", clazz
    # console.log "with:", props

    type = @get 'type'
    # finally create Model in store and return it!
    @get('store').load clazz, props

  build: (count = 1) ->
    self = @
    results = [1..count].map(
      (index) ->
        self.setup(index)
    )
    # console.log('mapped:', results);

    if count == 1 then results[0] else results

  f: Ember.Factory

  # TODO: How to improve this!? 
  _modelClass: (type) ->
    # console.log 'resolving class for ' + type
    window.App[type]

  _resolveValue: (value, index) ->
    type = Ember.typeOf(value)
    switch type
      when 'function'
        # lazy evaluated factory value :)
        value.apply(this, index)
      else
        value

Ember.Factory.reopenClass
  counter: (type) ->
    @counter_hash ||= {}
    counter = @counter_hash[type] ||= 0
    counter += 1
  build: (type, count = 1) ->
    Ember.factories.find(type).build(count)

Ember.Factories = Ember.Map

Ember.factories = Ember.Factories.create()

Ember.factories.use_store = (store) ->
  @set 'store', store

Ember.factories.store = () ->
  @get 'store'

Ember.factories.register = (factory) ->
  @set factory.get('type'), factory

Ember.factories.find = (type) ->
  @get type.classify()
