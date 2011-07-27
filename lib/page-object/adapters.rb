module PageObject
  module Adapters
    @@adapters = {}

    def self.get
      @@adapters
    end

    def self.register(key, adapter)
      @@adapters[key] = adapter
    end
  end
end
