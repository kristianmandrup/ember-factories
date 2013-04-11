$(function() {
  App = Ember.Application.create();

  App.Store = DS.Store.extend({
    revision: 12,
    adapter: DS.FixtureAdapter.create()
  });

  App.Person = DS.Model.extend({
    firstName: DS.attr('string'),
    lastName: DS.attr('string'),
    birthday: DS.attr('date'),

    fullName: function() {
      return this.get('firstName') + ' ' + this.get('lastName');
    }.property('firstName', 'lastName')
  });


  Ember.run(function() {
    store = DS.Store.create({revision: 12});

    Ember.factories.use_store(store);

    console.log('person'.classify());

    console.log('Factory map', Ember.Factories);
    console.log('Factories', window.Ember.factories);

    var person = store.createRecord(App.Person, {firstName: 'Kristian', lastName: 'Mandrup'});
    console.log(person);

    var factory_person = Ember.Factory.create({type: 'person'}).properties({firstName: 'Kris'});
    console.log('factory_person', factory_person);


    var kris = Ember.Factory.build('person');

    console.log('HELLO');

    console.log('kris was built via factory', kris);

  })
});
