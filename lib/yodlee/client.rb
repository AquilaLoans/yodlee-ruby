module Yodlee
  module Client

    # session = { cobSession, userSession }
    def self.execute(method, endpoint, session = nil, payload = nil)
      url     = Yodlee.configuration.base_path + endpoint
      headers = default_headers(session)
      body    = nil

      if payload
        if %i[get delete head].include?(method)
          headers[:params] = payload
        else
          body = JSON.dump(payload)
        end
      end

      RestClient::Request.execute(
        method:  method,
        url:     url,
        headers: headers,
        payload: body
      )
    end

    def self.default_headers(session)
      {
        'Accept'       => 'application/json',
        'Content-Type' => 'application/json'
      }.merge(authorization_headers(session))
    end

    def self.authorization_headers(session)
      return {} if session.nil? || session.empty?

      { 'Authorization' => '{' + session.map { |s| s.join('=') }.join(',') + '}' }
    end
  end
end