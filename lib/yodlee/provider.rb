module Yodlee
  class Provider < OpenStruct
    def initialize(user_session, params)
      @session = user_session
      super(params)
    end

    # GET /providers
    # @see https://developer.yodlee.com/apidocs/index.php#!/providers/getSuggestedSiteDetail
    def self.all(cobrand_session, options = {})
      endpoint = '/providers'

      response = Client.execute(:get, endpoint, cobrand_session, options)
      raw_providers = response[:provider] || []

      raw_providers.map do |raw_provider|
        Provider.new(cobrand_session, raw_provider)
      end
    end

    # GET /providers/{providerId}
    # @see https://developer.yodlee.com/apidocs/index.php#!/providers/getSiteDetail
    def self.find(cobrand_session, id)
      endpoint = "/providers/#{id}"

      response = Client.execute(:get, endpoint, cobrand_session)
      Provider.new(cobrand_session, response[:provider].first)
    end
  end

  class ProviderDelegator
    def initialize(cobrand_session)
      @session = cobrand_session
    end

    def all(options = {})
      Provider.all(@session, options)
    end

    def find(id)
      Provider.find(@session, id)
    end
  end
end
