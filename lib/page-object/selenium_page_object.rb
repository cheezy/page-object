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
    
    #
    # platform method to get the currently selected value from a select list
    # See PageObject::Accessors#select_list
    #
    def select_list_value_for(identifier)
      how, what = Elements::SelectList.selenium_identifier_for identifier
      @browser.find_element(how, what).attribute('value')
    end
    
    #
    # platform method to select a value from a select list
    # See PageObject::Accessors#select_list
    #
    def select_list_value_set(identifier, value)
      how, what = Elements::SelectList.selenium_identifier_for identifier
      @browser.find_element(how, what).send_keys(value)
    end
    
    #
    # platform method to return the select list element
    # See PageObject::Accessors#select_list
    #
    def select_list_for(identifier)
      how, what = Elements::SelectList.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::SelectList.new(element, :platform => :selenium)
    end

    #
    # platform method to click a link
    # See PageObject::Accessors#link
    #
    def click_link_for(identifier)
      how, what = Elements::Link.selenium_identifier_for identifier
      @browser.find_element(how, what).click
    end
    
    #
    # platform method to return a PageObject::Elements::Link object
    # see PageObject::Accessors#link
    #
    def link_for(identifier)
      how, what = Elements::Link.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::Link.new(element, :platform => :selenium)
    end

    #
    # platform method to check a checkbox
    # See PageObject::Accessors#checkbox
    #
    def check_checkbox(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).toggle unless checkbox_checked?(identifier)
    end

    #
    # platform method to uncheck a checkbox
    # See PageObject::Accessors#checkbox
    #
    def uncheck_checkbox(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).toggle if checkbox_checked?(identifier)
    end

    #
    # platform method to determine if a checkbox is checked
    # See PageObject::Accessors#checkbox
    #
    def checkbox_checked?(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).selected?
    end
    
    #
    # platform method to return a PageObject::Elements::CheckBox element
    # See PageObject::Accessors#checkbox
    #
    def checkbox_for(identifier)
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::CheckBox.new(element, :platform => :selenium)
    end

    #
    # platform method to select a radio button
    # See PageObject::Accessors#radio_button
    #
    def select_radio(identifier)
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
    end

    #
    # platform method to clear a radio button
    # See PageObject::Accessors#radio_button
    #
    def clear_radio(identifier)
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
    end

    #
    # platform method to determine if a radio button is selected
    # See PageObject::Accessors#radio_button
    #
    def radio_selected?(identifier)
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).selected?
    end
    
    #
    # platform method to return a PageObject::Eements::RadioButton element
    # See PageObject::Accessors#radio_button
    #
    def radio_button_for(identifier)
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::RadioButton.new(element, :platform => :selenium)
    end
  end
end
