module PageObject
  #
  # module which provides a function for determining
  # which platform to provide to the page object
  # 
  module ChoosesPlatform
    
    def determine_platform(browser, adapters)
      adapters.each { | adapter |
        return adapter.platform if adapter.is_for?(browser)
      }
      raise 'Unable to pick a platform for the provided browser' 
    end
  end
end
