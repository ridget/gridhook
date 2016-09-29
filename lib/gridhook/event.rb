require 'active_support/core_ext/hash/except'

module Gridhook
  class Event


    # Process a String or stream of JSON and execute our
    # event processor.
    #
    # body - A String or stream for MultiJson to parse
    #
    # Returns nothing.
    def self.process(params = {})
      if params.has_key? "_json"
        process_events params["_json"]
      else
        process_event params.except(:controller, :action)
      end
    end

    # The original Hash of attributes received from SendGrid.
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.with_indifferent_access
    end

    # An alias for returning the type of this event, ie:
    # sent, delivered, bounced, etc
    def name
      attributes[:event]
    end
    alias event name

    # Returns a new Time object from the event timestamp.
    def timestamp
      Time.at((attributes[:timestamp] || Time.now).to_i)
    end

    # A helper for accessing the original values sent from
    # SendGrid, ie
    #
    # Example:
    #
    #   event = Event.new(event: 'sent', email: 'lee@example.com')
    #   event[:event]  #=> 'sent'
    #   event['email'] #=> 'lee@example.com' # indifferent access
    def [](key)
      attributes[key]
    end

    class << self
      private

      def process_events(events)
        events.each { |e| process_event e }
      end

      def process_event(event)
       event_class.new(self.new(event)).public_send(processor_method)
      end

      def event_class
        Gridhook.configuration.event_class
      end

      def processor_method
        Gridhook.configuration.processor_method
      end
    end


  end

end
