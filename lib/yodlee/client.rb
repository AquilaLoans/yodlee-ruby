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

      raw_response = RestClient::Request.execute(
        method:  method,
        url:     url,
        headers: headers,
        payload: body
      )

      deep_format_response(JSON.parse(raw_response.body))
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

    def self.deep_format_response(object)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[key.underscore.to_sym] = deep_format_response(value)
        end
      when Array
        object.map { |array| deep_format_response(array) }
      when String
        return Date.parse(object) if /^\d{4}-\d{2}-\d{2}$/.match(object)
        object
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

      { 'Authorization' => '{' + session.map { |k, v| [k.to_s.camelize, v].join('=') }.join(',') + '}' }
    end
  end
end
