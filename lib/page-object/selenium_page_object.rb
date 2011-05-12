
module PageObject
  class SeleniumPageObject
    def initialize(browser)
      @browser = browser
    end

    def navigate_to(url)
      @browser.navigate.to url
    end
    
    def text
      @browser.find_element(:tag_name, 'body').text
    end
    
    def text_field_value_for(identifier)
      @browser.find_element(identifier).text
    end
    
    def text_field_value_set(identifier, value)
      @browser.find_element(identifier).send_keys(value)
    end
  
  end
end
