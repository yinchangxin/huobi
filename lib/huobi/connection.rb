require 'faraday'
require 'faraday/request/url_encoded'
require 'faraday/response/raise_error'
require 'huobi/response/parse_json'
require 'huobi/version'

module Huobi
  module Connection
  private

    def connection
      options = {
        headers:  {
          accept: 'application/json',
          user_agent: "huobi gem #{Huobi::VERSION}"
        },
        url: 'https://api.huobi.com/api.php',
        request: { open_timeout: 10, timeout: 5 }
      }

      Faraday.new(options) do |connection|
        connection.request :url_encoded
        connection.use Faraday::Response::RaiseError
        connection.use Huobi::Response::ParseJson
        connection.adapter(Faraday.default_adapter)
      end
    end
  end
end
