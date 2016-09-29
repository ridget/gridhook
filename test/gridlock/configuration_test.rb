require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase
  test 'configure block' do
    Gridhook.configure do |config|
      config.processor_method = :stuff_and_nonsense
    end

    assert_equal :stuff_and_nonsense, Gridhook.configuration.processor_method
  end

end
