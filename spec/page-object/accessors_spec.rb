require 'spec_helper'

class TestPageObject
  include PageObject

  page_url "http://apple.com"
  link(:google_search, :link => 'Google Search')
  text_field(:first_name, :id => 'first_name')
  hidden_field(:social_security_number, :id => 'ssn')
  text_area(:address, :id => 'address')
  select_list(:state, :id => 'state')
  checkbox(:active, :id => 'is_active_id')
  radio_button(:first, :id => 'first_choice')
  button(:click_me,  :id => 'button_submit')
  div(:message, :id => 'message_id')
  table(:cart, :id => 'cart_id')
  cell(:total, :id => 'total')
  span(:alert, :id => 'alert_id')
  image(:logo, :id => 'logo')
  form(:login, :id => 'login')
  list_item(:item_one, :id => 'one')
  unordered_list(:menu, :id => 'main_menu')
  ordered_list(:top_five, :id => 'top')
end

class BlockPageObject
  include PageObject
  
  attr_reader :value  
  
  text_field :first_name do |browser| "text_field" end
  hidden_field :secret do |browser| "hidden_field" end
  text_area :address do |browser| "text_area" end
  select_list :state do |browser| "select_list" end
  link :continue do |browser| "link" end
  checkbox :active do |browser| "checkbox" end
  radio_button :first do |browser| "radio_button" end
  button :click_me do |browser| "button" end
  div :footer do |browser| "div" end
  span :alert do |browser| "span" end
  table :cart do |browser| "table" end
  cell :total do |browser| "cell" end
  image :logo do |browser| "image" end
  form :login do |browser| "form" end
  list_item :item_one do |browser| "list_item" end
  unordered_list :menu do |browser| "unordered_list" end
  ordered_list :top_five do |browser| "ordered_list" end
end

describe PageObject::Accessors do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { TestPageObject.new(watir_browser) }
  let(:selenium_page_object) { TestPageObject.new(selenium_browser) }
  let(:block_page_object) { BlockPageObject.new(watir_browser) }
  
  describe "goto a page" do
    it "should navigate to a page when requested" do
      watir_browser.should_receive(:goto)
      page = TestPageObject.new(watir_browser, true)
    end
    
    it "should not navigate to a page when not requested" do
      watir_browser.should_not_receive(:goto)
      page = TestPageObject.new(watir_browser)
    end
    
    it "should not navigate to a page when 'page_url' not specified" do
      watir_browser.should_not_receive(:goto)
      page = BlockPageObject.new(watir_browser, true)
    end
  end
  
  describe "link accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:google_search)
        watir_page_object.should respond_to(:google_search_link)
      end
      
      it "should call a block on the element method when present" do
        block_page_object.continue_link.should == "link"
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
      
      it "should call a block on the element method when present" do
        block_page_object.first_name_text_field.should == "text_field"
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
  
      it "should call a block on the element method when present" do
        block_page_object.secret_hidden_field.should == "hidden_field"
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
      
      it "should retrieve a hidden field element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.social_security_number_hidden_field
        element.should be_instance_of PageObject::Elements::HiddenField
      end
    end
  end
  
  describe "text area accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:address)
        watir_page_object.should respond_to(:address=)
        watir_page_object.should respond_to(:address_text_area)
      end

      it "should call a block on the element method when present" do
        block_page_object.address_text_area.should == "text_area"
      end
    end
    
    context "watir implementation" do
      it "should set some text on the text area" do
        watir_browser.should_receive(:textarea).and_return(watir_browser)
        watir_browser.should_receive(:send_keys).with("123 main street")
        watir_page_object.address = "123 main street"
      end
      
      it "should get the text from the text area" do
        watir_browser.should_receive(:textarea).and_return(watir_browser)
        watir_browser.should_receive(:value).and_return("123 main street")
        watir_page_object.address.should == "123 main street"
      end
      
      it "should retrieve a text area element" do
        watir_browser.should_receive(:textarea).and_return(watir_browser)
        element = watir_page_object.address_text_area
        element.should be_instance_of PageObject::Elements::TextArea
      end
    end
    
    context "selenium implementation" do
      it "should set some text on the text area" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:send_keys).with("123 main street")
        selenium_page_object.address = "123 main street"
      end
      
      it "should get the text from the text area" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:attribute).with('value').and_return("123 main street")
        selenium_page_object.address.should == "123 main street"
      end
      
      it "should retrieve a text area element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.address_text_area
        element.should be_instance_of PageObject::Elements::TextArea
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

      it "should call a block on the element method when present" do
        block_page_object.state_select_list.should == "select_list"
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
      
      it "should call a block on the element method when present" do
        block_page_object.active_checkbox.should == "checkbox"
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
      
      it "should call a block on the element method when present" do
        block_page_object.first_radio_button.should == "radio_button"
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

      it "should call a block on the element method when present" do
        block_page_object.click_me_button.should == "button"
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

      it "should call a block on the element method when present" do
        block_page_object.footer_div.should == "div"
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

      it "should call a block on the element method when present" do
        block_page_object.alert_span.should == "span"
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
      
      it "should call a block on the element method when present" do
        block_page_object.cart_table.should == "table"
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

      it "should call a block on the element method when present" do
        block_page_object.total_cell.should == "cell"
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

      it "should call a block on the element method when present" do
        block_page_object.logo_image.should == "image"
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
  
  describe "form accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:login_form)
      end

      it "should call a block on the element method when present" do
        block_page_object.login_form.should == "form"
      end
    end
    
    context "watir implementation" do
      it "should retrieve the form element from the page" do
        watir_browser.should_receive(:form).and_return(watir_browser)
        element = watir_page_object.login_form
        element.should be_instance_of PageObject::Elements::Form
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the form element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.login_form
        element.should be_instance_of PageObject::Elements::Form
      end
    end
  end
  
  describe "list item accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:item_one)
        watir_page_object.should respond_to(:item_one_list_item)
      end

      it "should call a block on the element method when present" do
        block_page_object.item_one_list_item.should == "list_item"
      end
    end
    
    context "watir implementation" do
      it "should retrieve the text from the list item" do
        watir_browser.should_receive(:li).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.item_one.should == "value"
      end
      
      it "should retrieve the list item element from the page" do
        watir_browser.should_receive(:li).and_return(watir_browser)
        element = watir_page_object.item_one_list_item
        element.should be_instance_of PageObject::Elements::ListItem
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the text from the list item" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.item_one.should == "value"
      end
      
      it "should retrieve the list item from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.item_one_list_item
        element.should be_instance_of PageObject::Elements::ListItem
      end
    end
  end
  
  describe "unordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:menu_unordered_list)
      end

      it "should call a block on the element method when present" do
        block_page_object.menu_unordered_list.should == "unordered_list"
      end
    end
    
    context "watir implementation" do
      it "should retrieve the element from the page" do
        watir_browser.should_receive(:ul).and_return(watir_browser)
        element = watir_page_object.menu_unordered_list
        element.should be_instance_of PageObject::Elements::UnorderedList
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.menu_unordered_list
        element.should be_instance_of PageObject::Elements::UnorderedList
      end
    end
  end
  
  describe "ordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:top_five_ordered_list)
      end

      it "should call a block on the element method when present" do
        block_page_object.top_five_ordered_list.should == "ordered_list"
      end
    end
    
    context "watir implementation" do
      it "should retrieve the element from the page" do
        watir_browser.should_receive(:ol).and_return(watir_browser)
        element = watir_page_object.top_five_ordered_list
        element.should be_instance_of PageObject::Elements::OrderedList
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.top_five_ordered_list
        element.should be_instance_of PageObject::Elements::OrderedList
      end
    end
  end
end
