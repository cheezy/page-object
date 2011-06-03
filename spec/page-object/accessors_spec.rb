require 'spec_helper'

class TestPageObject
  include PageObject

  link(:google_search, :link => 'Google Search')
  text_field(:first_name, :id => 'first_name')
  hidden_field(:social_security_number, :id => 'ssn')
  select_list(:state, :id => 'state')
  checkbox(:active, :id => 'is_active_id')
  radio_button(:first, :id => 'first_choice')
  button(:click_me,  :id => 'button_submit')
  div(:message, :id => 'message_id')
  table(:cart, :id => 'cart_id')
  cell(:total, :id => 'total')
  span(:alert, :id => 'alert_id')
  image(:logo, :id => 'logo')
end

describe PageObject::Accessors do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { TestPageObject.new(watir_browser) }
  let(:selenium_page_object) { TestPageObject.new(selenium_browser) }
  
  describe "link accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:google_search)
        watir_page_object.should respond_to(:google_search_link)
      end
    end

    context "Watir implementation" do
      it "should select a link" do
        watir_browser.stub_chain(:link, :click)
        watir_page_object.google_search
      end
      
      it "should return a link element" do
        watir_browser.should_receive(:link).and_return(watir_browser)
        element = watir_page_object.google_search_link
        element.should be_instance_of PageObject::Elements::Link
      end
    end

    context "Selenium implementation" do
      it "should select a link" do
        selenium_browser.stub_chain(:find_element, :click)
        selenium_page_object.google_search
      end
      
      it "should return a link element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.google_search_link
        element.should be_instance_of PageObject::Elements::Link
      end
    end
  end


  describe "text_field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:first_name)
        watir_page_object.should respond_to(:first_name=)
        watir_page_object.should respond_to(:first_name_text_field)
      end
    end

    context "Watir implementation" do
      it "should get the text from the text field element" do
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        watir_browser.should_receive(:value).and_return('Kim')
        watir_page_object.first_name.should == 'Kim'
      end
    
      it "should set some text on a text field element" do
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        watir_browser.should_receive(:set).with('Kim')
        watir_page_object.first_name = 'Kim'
      end
      
      it "should retrieve a text field element" do
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        element = watir_page_object.first_name_text_field
        element.should be_instance_of PageObject::Elements::TextField
      end
    end

    context "Selenium implementation" do
      it "should get the text from the text field element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:attribute).with('value').and_return('Katie')
        selenium_page_object.first_name.should == 'Katie'
      end

      it "should set some text on a text field element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:send_keys).with('Katie')
        selenium_page_object.first_name = 'Katie'
      end
      
      it "should retrieve a text field element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.first_name_text_field
        element.should be_instance_of PageObject::Elements::TextField
      end
    end
  end
  
  
  describe "hidden field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:social_security_number)
        watir_page_object.should respond_to(:social_security_number_hidden_field)
      end
    end
    
    context "watir implementation" do
      it "should get the text from a hidden field" do
        watir_browser.should_receive(:hidden).and_return(watir_browser)
        watir_browser.should_receive(:value).and_return("value")
        watir_page_object.social_security_number.should == "value"
      end

      it "should retrieve a hidden field element" do
        watir_browser.should_receive(:hidden).and_return(watir_browser)
        element = watir_page_object.social_security_number_hidden_field
        element.should be_instance_of(PageObject::Elements::HiddenField)
      end
    end
    
    context "selenium implementation" do
      it "should get the text from a hidden field" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:attribute).with('value').and_return("12345")
        selenium_page_object.social_security_number.should == "12345"
      end
    end
  end

  describe "select_list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :state
        watir_page_object.should respond_to :state=
        watir_page_object.should respond_to(:state_select_list)
      end
    end
  
    context "Watir implementation" do
      it "should get the current item from a select list" do
        watir_browser.should_receive(:select_list).and_return watir_browser
        watir_browser.should_receive(:value).and_return("OH")
        watir_page_object.state.should == "OH"
      end
    
      it "should set the current item of a select list" do
        watir_browser.should_receive(:select_list).and_return watir_browser
        watir_browser.should_receive(:select).with("OH")
        watir_page_object.state = "OH"
      end
      
      it "should retreive the select list element" do
        watir_browser.should_receive(:select_list).and_return(watir_browser)
        element = watir_page_object.state_select_list
        element.should be_instance_of PageObject::Elements::SelectList
      end
    end
  
    context "Selenium implementation" do
      it "should should get the current item from a select list" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:attribute).and_return("OH")
        selenium_page_object.state.should == "OH"
      end
    
      it "should set the current item of a select list" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:send_keys).with("OH")
        selenium_page_object.state = "OH"
      end
      
      it "should retrieve the select list element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.state_select_list
        element.should be_instance_of PageObject::Elements::SelectList
      end
    end
  end

  
  describe "check_box accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :check_active
        watir_page_object.should respond_to :uncheck_active
        watir_page_object.should respond_to :active_checked?
        watir_page_object.should respond_to(:active_checkbox)
      end
    end

    context "Watir implementation" do
      it "should check a check box element" do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:set)
        watir_page_object.check_active
      end

      it "should clear a check box element" do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:clear)
        watir_page_object.uncheck_active
      end

      it "should know if a check box element is selected" do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        watir_browser.should_receive(:set?).and_return(true)
        watir_page_object.active_checked?.should be_true
      end
      
      it "should retrieve a checkbox element" do
        watir_browser.should_receive(:checkbox).and_return(watir_browser)
        element = watir_page_object.active_checkbox
        element.should be_instance_of PageObject::Elements::CheckBox
      end
    end

    context "Selenium implementation" do
      it "should check a check box element" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(false)
        selenium_browser.should_receive(:toggle)
        selenium_page_object.check_active
      end
    
      it "should clear a check box element" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_browser.should_receive(:toggle)
        selenium_page_object.uncheck_active
      end
    
      it "should know if a check box element is selected" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_page_object.active_checked?.should be_true
      end
      
      it "should retrieve a checkbox element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.active_checkbox
        element.should be_instance_of PageObject::Elements::CheckBox
      end
    end
  end
  
  
  describe "radio accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :select_first
        watir_page_object.should respond_to :clear_first
        watir_page_object.should respond_to :first_selected?
        watir_page_object.should respond_to(:first_radio_button)
      end
    end

    context "Watir implementation" do
      it "should select a radio button" do
        watir_browser.should_receive(:radio).and_return(watir_browser)
        watir_browser.should_receive(:set)
        watir_page_object.select_first
      end
      
      it "should clear a radio button" do
        watir_browser.should_receive(:radio).and_return(watir_browser)
        watir_browser.should_receive(:clear)
        watir_page_object.clear_first
      end
      
      it "should determine if a radio is selected" do
        watir_browser.should_receive(:radio).and_return(watir_browser)
        watir_browser.should_receive(:set?)
        watir_page_object.first_selected?
      end
      
      it "should retrieve a radio button element" do
        watir_browser.should_receive(:radio).and_return(watir_browser)
        element = watir_page_object.first_radio_button
        element.should be_instance_of PageObject::Elements::RadioButton
      end
    end

    context "Selenium implementation" do
      it "should select a radio button" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(false)
        selenium_browser.should_receive(:click)
        selenium_page_object.select_first
      end
      
      it "should clear a radio button" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_browser.should_receive(:click)
        selenium_page_object.clear_first
      end

      it "should determine if a radio is selected" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_page_object.first_selected?
      end
      
      it "should retrieve a radio button element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.first_radio_button
        element.should be_instance_of PageObject::Elements::RadioButton
      end
    end
  end

  describe "button accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :click_me
        watir_page_object.should respond_to :click_me_button
      end
    end
    
    context "watir implementation" do
      it "should be able to click a button" do
        watir_browser.should_receive(:button).and_return(watir_browser)
        watir_browser.should_receive(:click)
        watir_page_object.click_me
      end
      
      it "should retrieve a button element" do
        watir_browser.should_receive(:button).and_return(watir_browser)
        element = watir_page_object.click_me_button
        element.should be_instance_of PageObject::Elements::Button
      end
    end
    
    context "selenium implementation" do
      it "should be able to click a button" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:click)
        selenium_page_object.click_me
      end
      
      it "should retrieve a button element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.click_me_button
        element.should be_instance_of PageObject::Elements::Button
        
      end
    end
  end
  
  describe "div accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:message)
        watir_page_object.should respond_to(:message_div)
      end
    end
    
    context "watir implementation" do
      it "should retrieve the text from a div" do
        watir_browser.should_receive(:div).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("Message from div")
        watir_page_object.message.should == "Message from div"
      end
      
      it "should retrieve the div element from the page" do
        watir_browser.should_receive(:div).and_return(watir_browser)
        element = watir_page_object.message_div
        element.should be_instance_of PageObject::Elements::Div
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the text from a div" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("Message from div")
        selenium_page_object.message.should == "Message from div"
        
      end
      
      it "should retrieve the div element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.message_div
        element.should be_instance_of PageObject::Elements::Div
        
      end
    end
  end
  
  describe "span accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:alert)
        watir_page_object.should respond_to(:alert_span)
      end
    end
    
    context "watir implementation" do
      it "should retrieve the text from a span" do
        watir_browser.should_receive(:span).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("Alert")
        watir_page_object.alert.should == "Alert"
      end
      
      it "should retrieve the span element from the page" do
        watir_browser.should_receive(:span).and_return(watir_browser)
        element = watir_page_object.alert_span
        element.should be_instance_of PageObject::Elements::Span
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the text from a span" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("Alert")
        selenium_page_object.alert.should == "Alert"
      end
      
      it "should retrieve the span element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.alert_span
        element.should be_instance_of PageObject::Elements::Span
        
      end
    end
  end
  
  describe "table accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:cart_table)
      end
    end
    
    context "watir implementation" do
      it "should retrieve the table element from the page" do
        watir_browser.should_receive(:table).and_return(watir_browser)
        element = watir_page_object.cart_table
        element.should be_instance_of PageObject::Elements::Table
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the table element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.cart_table
        element.should be_instance_of(PageObject::Elements::Table)
        
      end
    end
  end
  
  describe "table cell accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:total)
        watir_page_object.should respond_to(:total_cell)
      end
    end
    
    context "watir implementation" do
      it "should retrieve the text for the cell" do
        watir_browser.should_receive(:td).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('10.00')
        watir_page_object.total.should == '10.00'
      end
      
      it "should retrieve the cell element from the page" do
        watir_browser.should_receive(:td).and_return(watir_browser)
        element = watir_page_object.total_cell
        element.should be_instance_of PageObject::Elements::TableCell
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the text from the cell" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return('celldata')
        selenium_page_object.total.should == 'celldata'
      end
    end
  end
  
  describe "image accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:logo_image)
      end
    end
    
    context "watir implementation" do
      it "should retrieve the image element from the page" do
        watir_browser.should_receive(:image).and_return(watir_browser)
        element = watir_page_object.logo_image
        element.should be_instance_of PageObject::Elements::Image
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the image element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.logo_image
        element.should be_instance_of PageObject::Elements::Image
      end
    end
  end
end
