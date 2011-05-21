require 'page-object/elements'

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

    def html
      @browser.page_source
    end

    def title
      @browser.title
    end
    
    def text_field_value_for(identifier)
      how, what = Elements::TextField.selenium_identifier_for identifier
      @browser.find_element(how, what).value
    end
    
    def text_field_value_set(identifier, value)
      how, what = Elements::TextField.selenium_identifier_for identifier
      @browser.find_element(how, what).send_keys(value)
    end
    
    def select_list_value_for(identifier)
      how, what = Elements::SelectList.selenium_identifier_for identifier
      @browser.find_element(how, what).attribute('value')
    end
    
    def select_list_value_set(identifier, value)
      how, what = Elements::SelectList.selenium_identifier_for identifier
      @browser.find_element(how, what).send_keys(value)
    end

    def click_link_for(identifier)
      how, what = Elements::Link.selenium_identifier_for identifier
      @browser.find_element(how, what).click
    end

    def check_checkbox(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).toggle unless checkbox_checked?(identifier)
    end

    def uncheck_checkbox(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).toggle if checkbox_checked?(identifier)
    end

    def checkbox_checked?(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).selected?
    end
    
    def checkbox_for(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::CheckBox.new(element, :platform => :selenium)
    end

    def select_radio(identifier)
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
    end

    def clear_radio(identifier)
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
    end

    def radio_selected?(identifier)
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).selected?
    end
  end
end
