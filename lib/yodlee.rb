require 'active_support/core_ext/string/inflections'
require 'rest-client'
require 'ostruct'
require 'json'

require 'yodlee/account'
require 'yodlee/app_ids'
require 'yodlee/client'
require 'yodlee/cobrand'
require 'yodlee/configuration'
require 'yodlee/provider'
require 'yodlee/transaction'
require 'yodlee/user'
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
