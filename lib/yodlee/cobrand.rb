module Yodlee
  class Cobrand < OpenStruct
    # POST /cobrand/login
    # @see https://developer.yodlee.com/apidocs/index.php#!/cobrand/authenticateCoBrand
    def self.login(login = Yodlee.configuration.cobrand_login, password = Yodlee.configuration.cobrand_password)
      endpoint = '/cobrand/login'
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

    # GET    /cobrand/config/notifications/events             Get Subscribed Events
    # PUT    /cobrand/config/notifications/events/{eventName} Update Subscription
    # DELETE /cobrand/config/notifications/events/{eventName} Delete Subscription
    # POST   /cobrand/config/notifications/events/{eventName} Subscribe Event
    # POST   /cobrand/logout                                  Cobrand Logout
    # GET    /cobrand/publicKey                               Get Public Key

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
