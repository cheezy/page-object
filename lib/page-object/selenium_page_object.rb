
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
  end
end
