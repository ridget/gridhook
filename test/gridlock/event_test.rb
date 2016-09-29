require 'test_helper'

# http://sendgrid.com/docs/API_Reference/Webhooks/event.html

class DummyEvent
  attr_reader :event, :events
  def initialize(event)
    @event = event
    @events = []
  end

  def process
    events << event
  end
end
class EventTest < ActiveSupport::TestCase

  def setup
    Gridhook.configure do |config|
      config.event_class = 'DummyEvent'
    end
  end

  test 'parsing a single incoming JSON object' do
    obj = { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'delivered' }
    event_array = process obj
    assert_equal 1, event_array.size
    assert_equal 'delivered', event_array.first.name
  end

  # for when sendgrid fix their JSON batch requests
  test 'parsing incoming (valid) JSON in batches' do
    obj = {"_json" => [
      { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'delivered' },
      { email: 'foo@bar.com', timestamp: Time.now.to_i, event: 'open' }
    ]}
    event_array = process obj
    assert_equal 2, event_array.size
  end

  test 'ensure we fallback to request parameters if invalid JSON found in body' do
    event_array = process(
      { :email => 'test@gmail.com', :arg2 => '2', :arg1 => '1', :category => 'testing',
        :event => 'processed', :controller => 'sendgrid', :action => 'receive'})
    assert_equal 1, event_array.size
    assert_equal 'processed', event_array.first.event
  end

  private

  def process(params = {})
    Gridhook::Event.process(params)
  end

end
