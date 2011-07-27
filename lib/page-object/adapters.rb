module PageObject
  module Platforms
    @@adapters = {}

    def self.get
      @@adapters
    end

    def self.register(key, adapter)
      @@adapters[key] = adapter
    end
  end
end
