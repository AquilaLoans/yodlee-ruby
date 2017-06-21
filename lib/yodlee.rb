require 'yodlee/configuration'
require 'yodlee/version'

module Yodlee
  class << self
    attr_reader :configuration
  end

  # Creates/sets a new configuration for the gem, yield a configuration object
  # @param new_configuration [Configuration] new configuration
  # @return [Configuration] the frozen configuration
  def self.configure(new_configuration = Configuration.new)
    yield(new_configuration) if block_given?

    @configuration = new_configuration.freeze
  end
end
