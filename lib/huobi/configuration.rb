module Huobi
  module Configuration
    VALID_OPTIONS_KEYS = [
      :key,
      :secret
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Reset all configuration options to defaults
    def reset
      self.key = nil
      self.secret = nil
      self
    end
  end
end
