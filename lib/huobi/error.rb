module Huobi
  class Error < StandardError; end
  class UnauthorizedError < Error; end
  class OrderNotFoundError < Error; end
end
