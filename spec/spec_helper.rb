require 'huobi'
require 'base64'
require 'json'
require 'rspec'

require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Huobi::Request
end

module Huobi
  module Request
    def a_get(path)
      a_request(:get, 'https://www.huobi.com' + path)
    end

    def stub_get(path)
      stub_request(:get, 'https://www.huobi.com' + path)
    end

    def a_post(options)
      options.merge! access_key: 'key', created: created_at
      a_request(:post, 'https://api.huobi.com/api.php').
        with(body: body_from_options(options))
    end

    def stub_post(options)
      options.merge! access_key: 'key', created: created_at
      stub_request(:post, 'https://api.huobi.com/api.php').
        with(body: body_from_options(options))
    end

    def fixture_path
      File.expand_path('../fixtures', __FILE__)
    end

    def fixture(file)
      File.new(fixture_path + '/' + file)
    end

    private
    def created_at
      '1392030332'
    end
  end
end
