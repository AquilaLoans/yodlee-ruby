module Yodlee
  class Account < OpenStruct
    def initialize(user_session, params)
      @session = user_session
      super(params)
    end

    # GET /accounts
    # @see https://developer.yodlee.com/apidocs/index.php#!/accounts/getAccounts
    def self.all(user_session)
      endpoint = '/accounts'

      response = Client.execute(:get, endpoint, user_session)
      raw_accounts = response[:account] || []

      raw_accounts.map do |raw_account|
        Account.new(user_session, raw_account)
      end
    end

    # GET /accounts/{accountId}
    # @see https://developer.yodlee.com/apidocs/index.php#!/accounts/getAccountDetails
    def self.find(user_session, container, id)
      endpoint = "/accounts/#{id}"
      payload  = { container: container }

      response = Client.execute(:get, endpoint, user_session, payload)
      Account.new(user_session, response[:account].first) if response[:account]
    end

    # POST   /accounts Add Manual Account
    # PUT    /accounts/{accountId} Update Account
    # GET    /accounts/historicalBalances Get Historical Balances

    # DELETE /accounts/{accountId}
    # @see https://developer.yodlee.com/apidocs/index.php#!/accounts/deleteAccountDetail
    def destroy
      endpoint = "/accounts/#{id}"

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
