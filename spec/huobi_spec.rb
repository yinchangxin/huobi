require 'spec_helper'

describe Huobi do
  describe ".new" do
    it "returns a Huobi::Client" do
      expect(Huobi.new).to be_a Huobi::Client
    end
  end

  describe ".configure" do
    it "sets key and secret" do
      Huobi.configure do |config|
        config.key = "key"
        config.secret = "secret"
      end

      expect(Huobi.key).to eq "key"
      expect(Huobi.secret).to eq "secret"
    end
  end

  describe "APIs" do
    before do
      @client = Huobi.new
      @client.configure do |config|
        config.key = "key"
        config.secret = "secret"
      end
    end

    describe "#ticker" do
      before do
        stub_get('/market/huobi.php?a=ticker').
          to_return(body: fixture('ticker.json'))
      end

      it "get ticker" do
        ticker = @client.ticker
        expect(a_get('/market/huobi.php?a=ticker')).to have_been_made
        expect(ticker['high']).to eq '4535'
      end
    end

    describe "#offers" do
      before do
        stub_get('/market/huobi.php?a=depth').
          to_return(body: fixture('offers.json'))
      end

      it "get market offers" do
        offers = @client.offers
        expect(a_get('/market/huobi.php?a=depth')).to have_been_made
        expect(offers['asks'][0]).to eq ["4531.96", 9]
      end
    end

    describe "#account" do
      before do
        @secret = 'secret'
        stub_post(method: 'get_account_info').
          to_return(body: fixture('account.json'))
      end

      it "get market offers" do
        account = @client.account
        expect(a_post(method: 'get_account_info')).to have_been_made
        expect(account['total']).to eq '5172.86'
      end
    end

    describe "#orders" do
      before do
        @secret = 'secret'
        stub_post(method: 'get_orders').
          to_return(body: fixture('orders.json'))
      end

      it "get orders" do
        orders = @client.orders
        expect(a_post(method: 'get_orders')).to have_been_made
        expect(orders[0]['order_price']).to eq '5107.000'
      end
    end

    describe "#buy" do
      before do
        @secret = 'secret'
        stub_post(method: 'buy', price: '1', amount: '1').
          to_return(body: fixture('buy.json'))
      end

      it "make a buy order" do
        order = @client.buy price: 1, amount: 1
        expect(a_post(method: 'buy', price: '1', amount: '1')).to have_been_made
        expect(order['result']).to eq 'success'
      end
    end

    describe "#sell" do
      before do
        @secret = 'secret'
        stub_post(method: 'sell', price: '1', amount: '1').
          to_return(body: fixture('sell.json'))
      end

      it "make a sell order" do
        order = @client.sell price: 1, amount: 1
        expect(a_post(method: 'sell', price: '1', amount: '1')).to have_been_made
        expect(order['result']).to eq 'success'
      end
    end

    describe "#cancel" do
      before do
        @secret = 'secret'
        stub_post(method: 'cancel_order', id: '1').
          to_return(body: fixture('cancel.json'))
      end

      it "cancel an order" do
        order = @client.cancel 1
        expect(a_post(method: 'cancel_order', id: '1')).to have_been_made
        expect(order['result']).to eq 'success'
      end
    end

    describe "#sync" do
      before do
        @secret = 'secret'
        stub_post(method: 'order_info', id: '1').
          to_return(body: fixture('sync.json'))
      end

      it "cancel an order" do
        order = @client.sync 1
        expect(a_post(method: 'order_info', id: '1')).to have_been_made
        expect(order['order_price']).to eq '5107.000'
      end
    end
  end
end
