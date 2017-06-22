module Yodlee
  class User < OpenStruct

    # POST /v1/user/login
    # @see https://developer.yodlee.com/apidocs/index.php#!/user/authenticateUser
    def self.login(cobrand_session, login, password)
      endpoint = '/v1/user/login'
      payload  = {
        user: {
          loginName: login,
          password: password,
          locale: 'en_US'
        }
      }

      response = Client.execute(:post, endpoint, cobrand_session, payload)
      User.new(cobrand_session, response[:user])
    end

    def initialize(cobrand_session, params)
      super(params)
      self.session.merge!(cobrand_session)
    end

    # POST   /v1/user/credentials        Update Password
    # POST   /v1/user/samlLogin          Saml Login
    # POST   /v1/user/logout             User Logout
    # POST   /v1/user/samlRegister       Saml Register
    # PUT    /v1/user                    Update User Details

    # GET /v1/user/accessTokens
    # @see https://developer.yodlee.com/apidocs/index.php#!/user/getAccessTokens
    def access_tokens(appIds)
      endpoint = '/v1/user/accessTokens'
      appIds   = appIds.join(',') if appIds.is_a?(Array)

      response = Client.execute(:get, endpoint, session, { appIds: appIds })
      response.dig(:user, :access_tokens).map do |access_token|
        OpenStruct.new(access_token)
      end
    end

    # DELETE /v1/user/unregister         Delete User
    # POST   /v1/user/register           Register User
    # GET    /v1/user                    Get User Details
    # GET    /v1/user/credentials/token

    def accounts
      @accounts ||= Yodlee::AccountDelegator.new(session)
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

    def login(login, password)
      User.login(@session, login, password)
    end
  end
end
