module PageObject
  #
  # module which provides a function for determining
  # which platform to provide to the page object
  # 
  module LoadsPlatform
    #
    # Determines which platform the Page Object should use based upon browser
    #
    # @example
    #  platform =  load_platform(watir_webdriver_browser, PageObject.Adapters.list).send(:new, watir_webdriver_browser)
    # 
    # @param [Object] A browser driver that has a supported adapter
    # @param [adapters] a list of adapters that are currently supported
    # @returns [PageObject] 
    #
    def load_platform(browser, adapters)
      adapters.each_value { |adapter|
        return adapter.create_page_object(browser) if adapter.is_for?(browser)
      }
      message = 'Unable to pick a platform for the provided browser.'
      message += "\nnil was passed to the PageObject constructor instead of a valid browser object." if browser.nil?
      raise message 
    end
  end
end
