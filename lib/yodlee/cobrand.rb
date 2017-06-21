module Yodlee
  class Cobrand
    attr_reader :session_token

    # @see https://developer.yodlee.com/apidocs/index.php#!/cobrand/authenticateCoBrand
    def self.login(login = Yodlee.configuration.cobrand_login, password = Yodlee.configuration.cobrand_password)
      endpoint = '/v1/cobrand/login'
      payload = {
        cobrand: {
          cobrandLogin: login,
          cobrandPassword: password,
          locale: 'en_US'
        }
      }

      response = Client.execute(:post, endpoint, nil, payload)
      Cobrand.new(JSON.parse(response.body).dig('session', 'cobSession'))
    end

    def initialize(session_token)
      @session_token = session_token
    end

    # POST   /v1/cobrand/logout Cobrand Logout
    # GET    /v1/cobrand/publicKey Get Public Key
    # DELETE /v1/cobrand/config/notifications/events/{eventName} Delete Subscription
    # PUT    /v1/cobrand/config/notifications/events/{eventName} Update Subscription
    # GET    /v1/cobrand/config/notifications/events Get Subscribed Events
    # POST   /v1/cobrand/config/notifications/events/{eventName}
  end
end
