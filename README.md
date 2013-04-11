# Ember Factories

Simple Factory library for use with Ember.js

## Installation

Add this line to your application's Gemfile:

    gem 'ember-factories', github: 'kristianmandrup/ember-factories'

And then execute:

    $ bundle

Or include js files from vendor/assets/javascripts directly ;)

## Status

Tested for basic functionality. Not sure if using `store.load` is sufficient to have *Ember* pick up that the data is there for the app. Anyone?

## Usage

Include `ember-factories.js` in your Ember project.

```coffeescript
# optionally point applicationClass to your own custom app name (default: App)


# define factories like this

Ember.factory.create('post').properties
  name: 'Kris'
  age: ->
    rand(20)
  email: ->
    "email#{rand(200)}@gmail.com"

## build models using build

post = Ember.Factory.build('post')

# or create multiple with an extra param

posts = Ember.Factory.build('post', 2)
```

Note that when you create multiple models, you will pass the index as an argument to any factory function, so you can fx change `email` to:

```coffeescript
Ember.factory.create('post').properties
  email: (n) ->
    "email#{n || 1}@gmail.com"
```

And it should create posts with `['email1@gmail.com', 'email2@gmail.com']

For global counting, use the `Ember.Factory.counter` f.ex `Ember.Factory.counter('posts')`

Note: When the factory instantiates a model, it creates an `f` property pointing to the factory class, so you can use the factory class method from your model in case you have special factory methods there. You can also use `f` inside your usual factory methods:

```coffeescript
Ember.factory.create('post').properties
  email: (n) ->
    "email#{f.count('emails')}@gmail.com"
```

Enjoy :)

PS: Please review and help improve the code...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
