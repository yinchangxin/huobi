require 'faraday'
require 'json'

module Huobi
  module Response
    class ParseJson < Faraday::Response::Middleware

      def parse(body)
        case body
        when /\A^\s*$\z/, nil
          nil
        else
          JSON.load(body)
        end
      end

      def on_complete(env)
        if respond_to?(:parse)
          begin
            env[:body] = parse(env[:body]) unless [204, 301, 302, 304].include?(env[:status])
          rescue JSON::ParserError => e
            env[:body] = {'code' => 1, 'msg' => e.to_s}
            env[:status] = 500
          end
        end
      end

    end
  end
end
