module Yodlee
  class ProviderAccount < OpenStruct
    def initialize(user_session, params)
      @session = user_session
      super(params)
    end

    # GET /v1/providerAccounts
    # @see https://developer.yodlee.com/apidocs/index.php#!/providerAccounts/getProviderAccount
    def self.all(user_session)
      endpoint = '/v1/providerAccounts'

      response = Client.execute(:get, endpoint, user_session)
      raw_provider_accounts = response[:provider_account] || []

      raw_provider_accounts.map do |raw_provider_account|
        ProviderAccount.new(user_session, raw_provider_account)
      end
    end

    # GET /v1/providerAccounts/{providerAccountId}
    # @see https://developer.yodlee.com/apidocs/index.php#!/providerAccounts/getRefreshForProviderAccount
    def self.find(user_session, id)
      endpoint = "/v1/providerAccounts/#{id}"

      response = Client.execute(:get, endpoint, user_session)
      ProviderAccount.new(user_session, response[:provider_account])
    end

    # PUT /v1/providerAccounts
    # @see https://developer.yodlee.com/apidocs/index.php#!/providerAccounts/updateAccount
    # @todo Create a fully supported update
    def refresh
      endpoint = "/v1/providerAccounts?providerAccountIds=#{id}"

      response = Client.execute(:put, endpoint, @session)
      ProviderAccount.new(user_session, response[:provider_account].first)
    end

    # POST   /v1/providerAccounts                                  Add Account
    # PUT    /v1/providerAccounts                                  Update Account
    # DELETE /v1/providerAccounts/{providerAccountId}              Delete Provider Account
    # PUT    /v1/providerAccounts/verification                     Verification Service
    # GET    /v1/providerAccounts/verification/{providerAccountId}

    # @note This is a synthetic interface and does not directly map to any api endpoints
    def accounts
      Yodlee::Account.all(@session).select do |account|
        account.provider_account_id == id
      end
    end
  end

  class ProviderAccountDelegator
    def initialize(user_session)
      @session = user_session
    end

    def all
      ProviderAccount.all(@session)
    end

    def find(id)
      ProviderAccount.find(@session, id)
    end
  end
end
