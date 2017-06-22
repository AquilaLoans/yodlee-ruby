module Yodlee
  class Transaction < OpenStruct
    def initialize(user_session, params)
      @session = user_session
      super(params)
    end

    # GET /v1/transactions
    # @see https://developer.yodlee.com/apidocs/index.php#!/transactions/getTransactions
    def self.all(user_session, options = {})
      endpoint = '/v1/transactions'

      response         = Client.execute(:get, endpoint, user_session, options)
      raw_transactions = response[:transaction] || []

      raw_transactions.map do |raw_transaction|
        Transaction.new(user_session, raw_transaction)
      end
    end

    # GET /v1/transactions/count
    # @see https://developer.yodlee.com/apidocs/index.php#!/transactions/getTransactionCount
    def self.count(user_session, options = {})
      endpoint = '/v1/transactions/count'

      response = Client.execute(:get, endpoint, user_session, options)
      response.dig(:transaction, :total, :count) || 0
    end

    # GET    /v1/transactions/categories                Get Transaction Category List
    # POST   /v1/transactions/categories                Create Category
    # PUT    /v1/transactions/categories                Update Category
    # DELETE /v1/transactions/categories/{categoryId}   Delete Category
    # POST   /v1/transactions/{transactionId}           Update Transaction Category
    # PUT    /v1/transactions/{transactionId}           Update Transaction
    # GET    /v1/transactions/categories/rules          Get Transaction Categorization Rules
    # POST   /v1/transactions/categories/rules          Create Transaction Categorization Rule
    # PUT    /v1/transactions/categories/rules/{ruleId} Update Transaction Categorization Rules
    # DELETE /v1/transactions/categories/rules/{ruleId} Delete Transaction Categorization Rule
    # POST   /v1/transactions/categories/rules/{ruleId} Run Transaction Categorization Rule
    # POST   /v1/transactions/categories/rules
  end

  class TransactionDelegator
    def initialize(user_session, account_id, container)
      @session         = user_session
      @default_options = { account_id: account_id, container: container }
    end

    def all(options = {})
      Transaction.all(@session, @default_options.merge(options))
    end

    def count(options = {})
      Transaction.count(@session, @default_options.merge(options))
    end
  end
end
