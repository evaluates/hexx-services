Hexx::Services
==============

[![Gem Version](https://img.shields.io/gem/v/hexx-services.svg?style=flat)][gem]
[![Build Status](https://img.shields.io/travis/nepalez/hexx-services/master.svg?style=flat)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/nepalez/hexx-services.svg?style=flat)][gemnasium]
[![Code Climate](https://img.shields.io/codeclimate/github/nepalez/hexx-services.svg?style=flat)][codeclimate]
[![Coverage](https://img.shields.io/coveralls/nepalez/hexx-services.svg?style=flat)][coveralls]
[![Inline docs](http://inch-ci.org/github/nepalez/hexx-services.svg)][inch]

[codeclimate]: https://codeclimate.com/github/nepalez/hexx-services
[coveralls]: https://coveralls.io/r/nepalez/hexx-services
[gem]: https://rubygems.org/gems/hexx-services
[gemnasium]: https://gemnasium.com/nepalez/hexx-services
[travis]: https://travis-ci.org/nepalez/hexx-services
[inch]: https://inch-ci.org/github/nepalez/hexx-services

The base class for domain service object

Synopsis
--------

Every service object is responcible for providing a single business operation.

Its API consists of 4 public methods:

* `.new` to instantiate the object.
* `#inject_dependency` to inject a dependency from another object.
* `#subscribe` to subscribe external listener for receiving the object's notification (events).
* `#call` to execute the object.

Except for API, the base class provides a DSL for the service, that includes the following private methods:

* `.attribute` to declare initializable attributes for the object.
* `.validate` and `.validates` to declare validations/policies for the object.
* `.depends_on` to declare the injectable dependency of the object from another service object class.

* `#attributes` with a hash of initialized attributes.
* `#execute` to do sequence operations, ending by invocation of `#publish!`, that throws `:published` exception to be catched by `#call`. If no exception was raised, the `#call` will publish `:success` event.
* `#invalid` to raise a validation error.
* `#validate` and `#validate!` to call declared validations when necessary.
* `#remember`, `#publish` and `#publish!` to create, collect, publish and return events.
* `#translate` to translate a text in the scope of the service object.

When defining a service you have to

* declare its attributes,
* declare validation rules,
* declare service dependencies,
* define the `#execute` method.

```ruby
class AddItem < Hexx::Services::Base

  attribute :uuid
  attribute :name, writer: -> value { Name.new value }

  validate  { invalid :blank unless uuid }
  validates :name

  depends_on :get_item, GetItem

  private

  def execute
    publish! :error unless validate.valid?
    event = get_item.new(uuid: uuid).call
    publish! :found if event.type == :found
    item = Item.save! attributes
    publish :added, "published", item: item
  end
end
```

Installation
------------

Add this line to your application's Gemfile:

```ruby
# Gemfile
gem "hexx-services"
```

Then execute:

```
bundle
```

Or add it manually:

```
gem install hexx-services
```

Compatibility
-------------

Tested under rubies [compatible to MRI 2.1+](.travis.yml).

Uses [RSpec] 3.0+ for testing and [hexx-suit] for dev/test tools collection.

[RSpec]: http://rspec.org
[hexx-suit]: https://github.com/nepalez/hexx-suit

Contributing
------------

* Read the [STYLEGUIDE](config/metrics/STYLEGUIDE)
* [Fork the project](https://github.com/nepalez/hexx-services)
* Create your feature branch (`git checkout -b my-new-feature`)
* Add tests for it
* Commit your changes (`git commit -am '[UPDATE] Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create a new Pull Request

License
-------

See the [MIT LICENSE](LICENSE).
