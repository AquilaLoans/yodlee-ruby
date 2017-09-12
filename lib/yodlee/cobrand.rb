module Yodlee
  class Cobrand < OpenStruct
    # POST /v1/cobrand/login
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
      response[:id] = response.delete(:cobrand_id)
      Cobrand.new(response)
    end

    # POST   /v1/cobrand/logout                                  Cobrand Logout
    # GET    /v1/cobrand/publicKey                               Get Public Key
    # DELETE /v1/cobrand/config/notifications/events/{eventName} Delete Subscription
    # PUT    /v1/cobrand/config/notifications/events/{eventName} Update Subscription
    # GET    /v1/cobrand/config/notifications/events             Get Subscribed Events
    # POST   /v1/cobrand/config/notifications/events/{eventName}

    def users
      @users ||= Yodlee::UserDelegator.new(session)
    end

    def providers
      @providers ||= Yodlee::ProviderDelegator.new(session)
    end

    def to_json
      to_h.to_json
    end

    def self.from_json(json)
      Cobrand.new(Client.deep_format_response(JSON.parse(json)))
    end
  end
end
