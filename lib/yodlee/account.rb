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

      JSON.parse(response.body)['account'].map do |raw_account|
        Account.new(user_session, raw_account)
      end
    end

    # GET /v1/accounts/{accountId}
    # @see https://developer.yodlee.com/apidocs/index.php#!/accounts/getAccountDetails
    def self.find(user_session, id, container)
      endpoint = "/v1/accounts/#{id}"
      payload  = { container: container }

      response    = Client.execute(:get, endpoint, user_session, payload)
      raw_account = JSON.parse(response.body)['account'].first

      Account.new(user_session, raw_account)
    end

    # POST   /v1/accounts/{accountId}                      Update Account Status
    # DELETE /v1/accounts/{accountId}                      Delete Account
    # GET    /v1/accounts/investmentPlan/investmentOptions Get Investment Options
    # GET    /v1/accounts/historicalBalances               Get Historical Balances
    # POST   /v1/accounts                                  Add Manual Account
    # PUT    /v1/accounts/{accountId}                      Update Account
  end

  class AccountDelegator
    def initialize(user_session)
      @session = user_session
    end

    def all
      Account.all(@session)
    end

    def find(id, container)
      Account.find(@session, id, container)
    end
  end
end
