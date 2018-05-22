module Yodlee
  class User < OpenStruct
    # POST /user/register
    # @see https://developer.yodlee.com/apidocs/index.php#!/user/register
    def self.create(cobrand_session, username, password, email, params = {})
      endpoint = '/user/register'
      payload  = {
        user: params.merge(
          login_name: username,
          password: password,
          email: email
        )
      }

      response = Client.execute(:post, endpoint, cobrand_session, payload)
      User.new(cobrand_session, response[:user])
    end

    # POST /user/login
    # @see https://developer.yodlee.com/apidocs/index.php#!/user/authenticateUser
    def self.login(cobrand_session, username, password)
      endpoint = '/user/login'
      payload  = {
        user: {
          login_name: username,
          password: password,
          locale: 'en_US'
        }
      }

      response = Client.execute(:post, endpoint, cobrand_session, payload)
      User.new(cobrand_session, response[:user])
    end

    def initialize(cobrand_session, params)
      super(params)
      session.merge!(cobrand_session)
    end

    # POST   /user/credentials       Update Password
    # POST   /user/samlLogin         Saml Login
    # POST   /user/logout            User Logout
    # POST   /user/samlRegister      Saml Register
    # PUT    /user                   Update User Details

    # GET /user/accessTokens
    # @see https://developer.yodlee.com/apidocs/index.php#!/user/getAccessTokens
    def access_tokens(app_ids)
      endpoint = '/user/accessTokens'
      app_ids  = app_ids.join(',') if app_ids.is_a?(Array)

      response = Client.execute(:get, endpoint, session, appIds: app_ids)
      response.dig(:user, :access_tokens).map do |access_token|
        OpenStruct.new(access_token)
      end
    end

    # DELETE /user/unregister
    # @see https://developer.yodlee.com/apidocs/index.php#!/user/unregister
    def destroy
      endpoint = '/user/unregister'

      Client.execute(:delete, endpoint, session)
      true
    end

    # GET    /user                   Get User Detail
    # GET    /user/credentials/token Get Token

    def accounts
      @accounts ||= Yodlee::AccountDelegator.new(session)
    end

    def provider_accounts
      @provider_accounts ||= Yodlee::ProviderAccountDelegator.new(session)
    end

    def to_json
      to_h.to_json
    end

    def self.from_json(json)
      User.new({}, Client.deep_format_response(JSON.parse(json)))
    end
  end

  class UserDelegator
    def initialize(cobrand_session)
      @session = cobrand_session
    end

    def create(username, password, email, params = {})
      User.create(@session, username, password, email, params)
    end

    def login(username, password)
      User.login(@session, username, password)
    end
  end
end
