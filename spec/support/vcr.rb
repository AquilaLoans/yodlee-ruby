# frozen_string_literal: true
require 'vcr'
require 'active_support/core_ext/string'

ENV['YODLEE_COBRAND_LOGIN']    = ENV.fetch('YODLEE_COBRAND_LOGIN',    'YODLEE_COBRAND_LOGIN')
ENV['YODLEE_COBRAND_PASSWORD'] = ENV.fetch('YODLEE_COBRAND_PASSWORD', 'YODLEE_COBRAND_PASSWORD')

ENV['YODLEE_USER_LOGIN']    = ENV.fetch('YODLEE_USER_LOGIN',    'YODLEE_USER_LOGIN')
ENV['YODLEE_USER_PASSWORD'] = ENV.fetch('YODLEE_USER_PASSWORD', 'YODLEE_USER_PASSWORD')

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock

  config.configure_rspec_metadata!

  config.filter_sensitive_data('YODLEE_COBRAND_LOGIN')    { ENV['YODLEE_COBRAND_LOGIN'] }
  config.filter_sensitive_data('YODLEE_COBRAND_PASSWORD') { ENV['YODLEE_COBRAND_PASSWORD'] }

  config.filter_sensitive_data('YODLEE_USER_LOGIN')    { ENV['YODLEE_USER_LOGIN'] }
  config.filter_sensitive_data('YODLEE_USER_PASSWORD') { ENV['YODLEE_USER_PASSWORD'] }
end

RSpec.configure do |config|
  # Add VCR to all tests
  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}

    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example
             .metadata[:full_description]
             .split(/\s+/, 2)
             .join('/')
             .underscore
             .strip
             .gsub(/[\.#]/, '/')
             .gsub(%r([^\w/]+), '_')
             .gsub(%(/$), '')
             .gsub('_/', '/')

      VCR.use_cassette(name, options, &example)
    end
  end
end
