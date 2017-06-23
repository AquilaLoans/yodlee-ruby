module Yodlee
  class Configuration < OpenStruct
    DEVELOPMENT_BASE_PATH = 'https://developer.api.yodlee.com:443/ysl/restserver'.freeze

    DEFAULTS = {
      cobrand_login:    nil,
      cobrand_password: nil,
      base_path:        DEVELOPMENT_BASE_PATH
    }.freeze

    # Creates a new Configuration from the passed in parameters
    # @param params [Hash] configuration options
    # @return [Configuration]
    def initialize(params = {})
      super(DEFAULTS.merge(params))
    end
  end
end
