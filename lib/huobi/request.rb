require 'base64'

module Huobi
  module Request
    def get(path, options={})
      request(:get, path, options)
    end

    def post(path, options={})
      options.merge! created: created_at, access_key: @key
      request(:post, path, options)
    end

  private

    def request(method, path, options)
      response = connection.send(method) do |request|
        case method
        when :get
          request.url(path, options)
        when :post
          request.path = path
          request.body = body_from_options(options)
        end
      end
      response.body
    end

    def sign(options)
      str = options.merge(secret_key: @secret)
        .sort.collect{|arr| "#{arr[0]}=#{arr[1]}" }.join('&')

      Digest::MD5.hexdigest(str)
    end

    def body_from_options(options)
      options.merge(sign: sign(options))
    end

    def created_at
      Time.now.to_i
    end
  end
end
