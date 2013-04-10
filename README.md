# Ember Factories

Simple Factory library for use with Ember.js

## Installation

Add this line to your application's Gemfile:

    gem 'ember-factories'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ember-factories

Or include js files from vendor/assets/javascripts directly ;)

## Usage

Include `ember-factories.js.coffee` in your Ember project.

```coffeescript
# optionally point applicationClass to your own custom app name (default: App)
Ember.applicationClass = MyApp

# define factories like this
Ember.factory.create('post').properties
  name: 'Kris'
  age: ->
    rand(20)
  email: ->
    "email#{rand(200)}@gmail.com"

## use factories in testing

post = Ember.factory_for('post')
```

Enjoy :)

PS: Please review and help improve the code...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
