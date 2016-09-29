module Gridhook
  @@configuration = nil

  def self.configure
    @@configuration = Configuration.new

    if block_given?
      yield configuration
    end

    configuration
  end

  def self.configuration
    @@configuration || configure
  end

  class Configuration
    attr_accessor :processor_method, :event_class, :event_receive_path

    def event_class
      @event_class ||=
        begin
          EmailEvent.to_s
        rescue NameError
          raise NameError.new(<<-ERROR.strip_heredoc, 'EmailProcessor')
            To use Gridhook, you must either define `EmailEvent` or configure a
            different event class. See https://github.com/ridget/gridhook#installation for
            more information.
          ERROR
        end
      @event_class.constantize
    end

    def processor_method
      @processor_method ||= :process
    end

    def event_receive_path
      @event_receive_path ||= '/sendgrid/event'
    end
  end
end
