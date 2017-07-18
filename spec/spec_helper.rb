require 'simplecov'
require 'pry'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start do
  add_filter '/spec/'
end

require 'bundler/setup'
require 'dotenv/load'
require 'yodlee'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  # config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random
  Kernel.srand config.seed
end

require_relative 'support/vcr'

RSpec.shared_context 'configure', shared_context: :metadata do
  before(:each) do
    Yodlee.configure do |config|
      config.cobrand_login    = ENV.fetch('YODLEE_COBRAND_LOGIN')
      config.cobrand_password = ENV.fetch('YODLEE_COBRAND_PASSWORD')
      config.base_path        = ENV.fetch('YODLEE_BASE_PATH', Yodlee::Configuration::DEVELOPMENT_BASE_PATH)
    end
  end
end

RSpec.shared_context 'session', shared_context: :metadata do
  let(:cobrand)      { Yodlee::Cobrand.login }
  let(:username)     { ENV.fetch('YODLEE_USER_LOGIN') }
  let(:password)     { ENV.fetch('YODLEE_USER_PASSWORD') }
  let(:user)         { Yodlee::User.login(cobrand.session, username, password) }

  let(:cobrand_session) { cobrand.session }
  let(:user_session)    { user.session }
end
