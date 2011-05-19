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
    
    def select_list_value_for(identifier)
      identifier = SelectList.watir_identifier_for identifier
      @browser.select_list(identifier).value
    end
    
    def select_list_value_set(identifier, value)
      identifier = SelectList.watir_identifier_for identifier
      @browser.select_list(identifier).select(value)
    end
        
    def click_link_for(identifier)
      identifier = Link.watir_identifier_for identifier
      @browser.link(identifier).click if identifier
    end

    def check_checkbox(identifier)
      @browser.checkbox(identifier).set
    end

    def uncheck_checkbox(identifier)
      @browser.checkbox(identifier).clear
    end

    def checkbox_checked?(identifier)
      @browser.checkbox(identifier).set?
    end
  end
end
