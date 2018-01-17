module Yodlee
  class Account < OpenStruct
    def initialize(user_session, params)
      @session = user_session
      super(params)
    end

    # GET /v1/accounts
    # @see https://developer.yodlee.com/apidocs/index.php#!/accounts/getAccounts
    def self.all(user_session)
      endpoint = '/v1/accounts'

      response = Client.execute(:get, endpoint, user_session)
      raw_accounts = response[:account] || []

      raw_accounts.map do |raw_account|
        Account.new(user_session, raw_account)
      end
    end

    # GET /v1/accounts/{accountId}
    # @see https://developer.yodlee.com/apidocs/index.php#!/accounts/getAccountDetails
    def self.find(user_session, container, id)
      endpoint = "/v1/accounts/#{id}"
      payload  = { container: container }

      response = Client.execute(:get, endpoint, user_session, payload)
      Account.new(user_session, response[:account].first)
    end

    # POST   /v1/accounts/{accountId}                      Update Account Status
    # GET    /v1/accounts/investmentPlan/investmentOptions Get Investment Options
    # GET    /v1/accounts/historicalBalances               Get Historical Balances
    # POST   /v1/accounts                                  Add Manual Account
    # PUT    /v1/accounts/{accountId}                      Update Account

    # DELETE /v1/accounts/{accountId}
    # @see https://developer.yodlee.com/apidocs/index.php#!/accounts/deleteAccountDetail
    def destroy
      endpoint = "/v1/accounts/#{id}"

      Client.execute(:delete, endpoint, @session)
    end

    def transactions
      @transactions ||= Yodlee::TransactionDelegator.new(@session, id, self.CONTAINER)
    end

    def provider_account
      @provider_account ||= Yodlee::ProviderAccountDelegator.new(@session).find(provider_account_id)
    end
  end

  class AccountDelegator
    def initialize(user_session)
      @session = user_session
    end

    def all
      Account.all(@session)
    end

    def find(container, id)
      Account.find(@session, container, id)
    end
  end
end
