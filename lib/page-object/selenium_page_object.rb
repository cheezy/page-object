
module PageObject
  class SeleniumPageObject
    def initialize(browser)
      @browser = browser
    end
    
    def text
      @browser.body_text
    end
  end
end
