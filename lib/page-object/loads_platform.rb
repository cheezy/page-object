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
      adapter_for(browser,adapters).create_page_object(browser)
    end

    def browser_for root,adapters
      adapter_for(root,adapters).browser_for(root)
    end

    def adapter_for element_or_browser, adapters
      adapter = adapters.values.find { |adapter|
        adapter.is_for?(element_or_browser)
      }
      unless adapter
        message = "Unable to pick a platform for the provided browser or element: #{element_or_browser.inspect}."
        message += "\nnil was passed to the PageObject constructor instead of a valid browser or element object." if element_or_browser.nil?
        raise message
      end
      adapter
    end

    def root_element_for root, adapters
      adapter_for(root,adapters).root_element_for(root)
    end

    def browser_root_for browser, adapters
      adapter_for(browser,adapters).browser_root_for(browser)
    end
  end
end
