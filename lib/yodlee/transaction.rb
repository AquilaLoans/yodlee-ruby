module Yodlee
  class Transaction < OpenStruct
    def initialize(user_session, params)
      @session = user_session
      super(params)
    end

    # GET /transactions
    # @see https://developer.yodlee.com/apidocs/index.php#!/transactions/getTransactions
    def self.all(user_session, options = {})
      endpoint = '/transactions'

      response         = Client.execute(:get, endpoint, user_session, options)
      raw_transactions = response[:transaction] || []

      raw_transactions.map do |raw_transaction|
        Transaction.new(user_session, raw_transaction)
      end
    end

    # GET /transactions/count
    # @see https://developer.yodlee.com/apidocs/index.php#!/transactions/getTransactionCount
    def self.count(user_session, options = {})
      endpoint = '/transactions/count'

      response = Client.execute(:get, endpoint, user_session, options)
      response.dig(:transaction, :total, :count) || 0
    end

    # GET    /transactions/categories/rules          Get Transaction Categorization Rules
    # POST   /transactions/categories/rules          Create Transaction Categorization Rule
    # PUT    /transactions/categories/rules/{ruleId} Update Transaction Categorization Rules
    # DELETE /transactions/categories/rules/{ruleId} Delete Transaction Categorization Rule
    # POST   /transactions/categories/rules/{ruleId} Run Transaction Categorization Rule
    # POST   /transactions/categories/rules          Run All Transaction Categorization Rules
    # DELETE /transactions/categories/{categoryId}   Delete Category
    # PUT    /transactions/{transactionId}           Update Transaction
    # GET    /transactions/categories                Get Transaction Category List
    # POST   /transactions/categories                Create Category
    # PUT    /transactions/categories                Update Category
  end

  class TransactionDelegator
    def initialize(user_session, container, account_id)
      @session         = user_session
      @default_options = { container: container, account_id: account_id }
    end

    def all(options = {})
      Transaction.all(@session, @default_options.merge(options))
    end

    def count(options = {})
      Transaction.count(@session, @default_options.merge(options))
    end
  end
end
