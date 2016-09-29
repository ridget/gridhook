# Gridhook

Gridhook is a Rails engine providing an endpoint for handling incoming
SendGrid webhook events.

This engine supports both batched and non-batched events from SendGrid.

Looking to handle incoming email from the SendGrid Parse API? Gridhook
will eventually support that, until then, you should check out
[Griddler](https://github.com/thoughtbot/griddler). It's awesome.

## Installation

Add Gridhook to your application's Gemfile and run `bundle install`:

```ruby
gem 'gridhook'
```

You must also tell Gridhook how to process your event. Simply add an
initializer in `config/initializers/gridhook.rb`:

```ruby
Gridhook.configure do |config|
  # The path we want to receive events
  config.event_receive_path = '/sendgrid/event'
  
  config.event_class = 'EmailEvent'
  
  config.processor_method = :process
end
```

The `config.event_class` will need to take a single argument: `event` as its only constructor argument.

it must define either a `process` instance method, or alternatively you can supply your own in the configuration options with `processor_method`

```ruby
class EmailEvent
  def initialize(event)
  end
  
  def process
  end
end
```

## Changelog
v0.2.3 update engine to be more current. drop rails 3 support. Enable different configuration approach

v0.2.2 Require decorators as dependency

v0.2.1 Use built-in rails JSON parser.

v0.2.0 Supports version 3 of the Sendgrid webhook released on 
September 6th, 2013, which provides the proper headers and JSON post body
without hacks or middleware. If upgrading to this version, please make sure
to update the Webhooks settings in your SendGrid App to use V3 of their API.

## TODO

* More tests
* Integrate [parse webhook](http://sendgrid.com/docs/API_Reference/Webhooks/parse.html)

## More Information

* [Gridhook API Documentation](http://injekt.github.com/rdoc/gridhook/)
* [SendGrid Webhooks](http://sendgrid.com/docs/API_Reference/Webhooks/index.html)
* [SendGrid Webhooks/Event](http://sendgrid.com/docs/API_Reference/Webhooks/event.html)
