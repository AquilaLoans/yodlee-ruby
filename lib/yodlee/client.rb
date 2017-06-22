module Yodlee
  module Client

    # session = { cobSession, userSession }
    def self.execute(method, endpoint, session = nil, payload = nil)
      url     = Yodlee.configuration.base_path + endpoint
      headers = default_headers(session)
      payload = deep_format_payload(payload)
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

    # @see https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/hash/keys.rb#L143-L154
    def self.deep_format_payload(object)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[key.to_s.camelize(:lower)] = deep_format_payload(value)
        end
      when Array
        object.map { |array| deep_format_payload(array) }
      when Date, DateTime, Time
        object.strftime('%Y-%m-%d')
      else
        object
      end
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
