module Yodlee
  class User < OpenStruct

    # @see https://developer.yodlee.com/apidocs/index.php#!/user/authenticateUser
    def self.login(cobrand, login, password)
      endpoint = '/v1/user/login'
      payload  = {
        user: {
          loginName: login,
          password: password,
          locale: 'en_US'
        }
      }

      response = Client.execute(:post, endpoint, cobrand.session, payload)
      User.new(cobrand, JSON.parse(response.body)['user'])
    end

    def initialize(cobrand, params)
      super(params)
      self.session.merge!(cobrand.session)
    end

    # POST   /v1/user/credentials        Update Password
    # POST   /v1/user/samlLogin          Saml Login
    # POST   /v1/user/logout             User Logout
    # POST   /v1/user/samlRegister       Saml Register
    # PUT    /v1/user                    Update User Details
    # GET    /v1/user/accessTokens       Get Access Tokens
    # DELETE /v1/user/unregister         Delete User
    # POST   /v1/user/register           Register User
    # GET    /v1/user                    Get User Details
    # GET    /v1/user/credentials/token
  end
end
