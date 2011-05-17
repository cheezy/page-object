require 'page-object/elements'

module PageObject
  class WatirPageObject
    def initialize(browser)
      @browser = browser      
    end

    def navigate_to(url)
      @browser.goto url
    end
    
    def text
      @browser.text
    end

    def html
      @browser.html
    end

    def title
      @browser.title
    end

    def text_field_value_for(identifier)
      identifier = TextField.watir_identifier_for identifier
      @browser.text_field(identifier).value
    end
    
    def text_field_value_set(identifier, value)
      identifier = TextField.watir_identifier_for identifier
      @browser.text_field(identifier).set(value)
    end
        
    def click_link_for(identifier)
      identifier = Link.watir_identifier_for identifier
      @browser.link(identifier).click if identifier
    end
  end
end
