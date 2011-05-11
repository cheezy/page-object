
module PageObject
  class WatirPageObject
    def initialize(browser)
      @browser = browser      
    end
    
    def text
      @browser.text
    end
  end
end
