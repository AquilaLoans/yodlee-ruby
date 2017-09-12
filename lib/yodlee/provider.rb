module Yodlee
  class Provider < OpenStruct
    def initialize(user_session, params)
      @session = user_session
      super(params)
    end

    # GET  /v1/providers
    # @see https://developer.yodlee.com/apidocs/index.php#!/providers/getSuggestedSiteDetail
    def self.all(user_session, options = {})
      endpoint = '/v1/providers'

      response = Client.execute(:get, endpoint, user_session, options)
      raw_providers = response[:provider] || []

      raw_providers.map do |raw_provider|
        Provider.new(user_session, raw_provider)
      end
    end

    # GET  /v1/providers/{providerId}        Get Provider Details
    # POST /v1/providers/{providerId}        Add Account
    # PUT  /v1/providers/{providerAccountId} Update Account
    # GET  /v1/providers/token               Get Token
  end

  # GET    /v1/providerAccounts/{providerAccountId}              Get Provider Account Details
  # PUT    /v1/providerAccounts                                  Update Account
  # DELETE /v1/providerAccounts/{providerAccountId}              Delete Provider Account
  # GET    /v1/providerAccounts                                  Get Provider Accounts
  # POST   /v1/providerAccounts                                  Add Account
  # PUT    /v1/providerAccounts/verification                     Verification Service
  # GET    /v1/providerAccounts/verification/{providerAccountId}

  class ProviderDelegator
    def initialize(cobrand_session)
      @session = cobrand_session
    end

    def all(options = {})
      Provider.all(@session, options)
    end
  end
end
