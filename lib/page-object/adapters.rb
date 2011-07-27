module PageObject
  module Adapters
    @@adapters = {}
    def self.get
      @@adapters
    end
    def self.register(key, adapter)
      puts key
      @@adapters[key] = adapter
      puts @@adapters
    end
  end
end
