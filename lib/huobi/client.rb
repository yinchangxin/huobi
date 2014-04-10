require 'faraday/error'
require 'huobi/connection'
require 'huobi/request'
require 'huobi/configuration'

module Huobi
  class Client
    include Huobi::Connection
    include Huobi::Request
    include Huobi::Configuration

    def ticker
      get('https://www.huobi.com/market/huobi.php?a=ticker')['ticker']
    end

    def offers
      get 'https://www.huobi.com/market/huobi.php?a=depth'
    end

    def account
      post '', method: 'get_account_info'
    end

    def orders
      post '', method: 'get_orders'
    end

    def buy options
      post '', method: 'buy', price: options[:price], amount: options[:amount]
    end

    def sell options
      post '', method: 'sell', price: options[:price], amount: options[:amount]
    end

    def cancel order_id
      post '', method: 'cancel_order', id: order_id
    end

    def sync order_id
      post '', method: 'order_info', id: order_id
    end
  end
end
