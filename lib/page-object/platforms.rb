require 'page-object/loads_platform'

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
require 'page-object/platforms/watir_webdriver'
require 'page-object/platforms/selenium_webdriver'

