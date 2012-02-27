require 'spec_helper'

class AccessorsTestPageObject
  include PageObject

  page_url "http://apple.com"
  expected_title "Expected Title"
  link(:google_search, :link => 'Google Search')
  text_field(:first_name, :id => 'first_name')
  hidden_field(:social_security_number, :id => 'ssn')
  text_area(:address, :id => 'address')
  select_list(:state, :id => 'state')
  checkbox(:active, :id => 'is_active_id')
  radio_button(:first, :id => 'first_choice')
  button(:click_me, :id => 'button_submit')
  div(:message, :id => 'message_id')
  table(:cart, :id => 'cart_id')
  cell(:total, :id => 'total')
  span(:alert, :id => 'alert_id')
  image(:logo, :id => 'logo')
  form(:login, :id => 'login')
  list_item(:item_one, :id => 'one')
  unordered_list(:menu, :id => 'main_menu')
  ordered_list(:top_five, :id => 'top')
  h1(:heading1, :id => 'main_heading')
  h2(:heading2, :id => 'main_heading')
  h3(:heading3, :id => 'main_heading')
  h4(:heading4, :id => 'main_heading')
  h5(:heading5, :id => 'main_heading')
  h6(:heading6, :id => 'main_heading')
  paragraph(:first_para, :id => 'first')
  file_field(:upload_me, :id => 'the_file')
end

class BlockPageObject
  include PageObject

  attr_reader :value

  text_field :first_name do |element|
    "text_field"
  end
  hidden_field :secret do |element|
    "hidden_field"
  end
  text_area :address do |element|
    "text_area"
  end
  select_list :state do |element|
    "select_list"
  end
  link :continue do |element|
    "link"
  end
  checkbox :active do |element|
    "checkbox"
  end
  radio_button :first do |element|
    "radio_button"
  end
  button :click_me do |element|
    "button"
  end
  div :footer do |element|
    "div"
  end
  span :alert do |element|
    "span"
  end
  table :cart do |element|
    "table"
  end
  cell :total do |element|
    "cell"
  end
  image :logo do |element|
    "image"
  end
  form :login do |element|
    "form"
  end
  list_item :item_one do |element|
    "list_item"
  end
  unordered_list :menu do |element|
    "unordered_list"
  end
  ordered_list :top_five do |element|
    "ordered_list"
  end
  h1 :heading1 do |element|
    "h1"
  end
  h2 :heading2 do |element|
    "h2"
  end
  h3 :heading3 do |element|
    "h3"
  end
  h4 :heading4 do |element|
    "h4"
  end
  h5 :heading5 do |element|
    "h5"
  end
  h6 :heading6 do |element|
    "h6"
  end
  paragraph :first_para do |element|
    "p"
  end
  file_field :a_file do |element|
    "file_field"
  end
end

describe PageObject::Accessors do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { AccessorsTestPageObject.new(watir_browser) }
  let(:selenium_page_object) { AccessorsTestPageObject.new(selenium_browser) }
  let(:block_page_object) { BlockPageObject.new(watir_browser) }
  
  before(:each) do
    selenium_browser.stub(:switch_to).and_return(selenium_browser)
    selenium_browser.stub(:default_content)
  end

  describe "goto a page" do
    it "should navigate to a page when requested" do
      watir_browser.should_receive(:goto)
      page = AccessorsTestPageObject.new(watir_browser, true)
    end

    it "should not navigate to a page when not requested" do
      watir_browser.should_not_receive(:goto)
      page = AccessorsTestPageObject.new(watir_browser)
    end

    it "should not navigate to a page when 'page_url' not specified" do
      watir_browser.should_not_receive(:goto)
      page = BlockPageObject.new(watir_browser, true)
    end
  end

  describe "validating the page title" do
    it "should validate the title" do
      watir_browser.should_receive(:title).and_return("Expected Title")
      watir_page_object.should have_expected_title
    end

    it "should raise error when it does not have expected title" do
      watir_browser.should_receive(:title).twice.and_return("Not Expected")
      expect { watir_page_object.has_expected_title? }.to raise_error
    end
  end

  describe "link accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:google_search)
        watir_page_object.should respond_to(:google_search_element)
        watir_page_object.should respond_to(:google_search_link)
      end

      it "should call a block on the element method when present" do
        block_page_object.continue_element.should == "link"
      end
    end

    context "Watir implementation" do
      it "should select a link" do
        watir_browser.stub_chain(:link, :click)
        watir_page_object.google_search
      end

      it "should return a link element" do
        watir_browser.should_receive(:link).and_return(watir_browser)
        element = watir_page_object.google_search_element
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
        element = selenium_page_object.google_search_element
        element.should be_instance_of PageObject::Elements::Link
      end
    end
  end


  describe "text_field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:first_name)
        watir_page_object.should respond_to(:first_name=)
        watir_page_object.should respond_to(:first_name_element)
        watir_page_object.should respond_to(:first_name_text_field)
      end

      it "should call a block on the element method when present" do
        block_page_object.first_name_element.should == "text_field"
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
        element = watir_page_object.first_name_element
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
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:clear)
        selenium_browser.should_receive(:send_keys).with('Katie')
        selenium_page_object.first_name = 'Katie'
      end

      it "should retrieve a text field element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.first_name_element
        element.should be_instance_of PageObject::Elements::TextField
      end
    end
  end


  describe "hidden field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:social_security_number)
        watir_page_object.should respond_to(:social_security_number_element)
        watir_page_object.should respond_to(:social_security_number_hidden_field)
      end

      it "should call a block on the element method when present" do
        block_page_object.secret_element.should == "hidden_field"
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
        element = watir_page_object.social_security_number_element
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
        element = selenium_page_object.social_security_number_element
        element.should be_instance_of PageObject::Elements::HiddenField
      end
    end
  end

  describe "text area accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:address)
        watir_page_object.should respond_to(:address=)
        watir_page_object.should respond_to(:address_element)
        watir_page_object.should respond_to(:address_text_area)
      end

      it "should call a block on the element method when present" do
        block_page_object.address_element.should == "text_area"
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
        element = watir_page_object.address_element
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
        element = selenium_page_object.address_element
        element.should be_instance_of PageObject::Elements::TextArea
      end
    end
  end

  describe "select_list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :state
        watir_page_object.should respond_to :state=
        watir_page_object.should respond_to(:state_element)
        watir_page_object.should respond_to(:state_select_list)
      end

      it "should call a block on the element method when present" do
        block_page_object.state_element.should == "select_list"
      end
    end

    context "Watir implementation" do
      it "should get the current item from a select list" do
        selected = "OH"
        selected.should_receive(:selected?).and_return(selected)
        selected.should_receive(:text).and_return("OH")
        watir_browser.should_receive(:select_list).and_return watir_browser
        watir_browser.should_receive(:options).and_return([selected])
        watir_page_object.state.should == "OH"
      end

      it "should set the current item of a select list" do
        watir_browser.should_receive(:select_list).and_return watir_browser
        watir_browser.should_receive(:select).with("OH")
        watir_page_object.state = "OH"
      end

      it "should retreive the select list element" do
        watir_browser.should_receive(:select_list).and_return(watir_browser)
        element = watir_page_object.state_element
        element.should be_instance_of PageObject::Elements::SelectList
      end
    end

    context "Selenium implementation" do
      it "should should get the current item from a select list" do
        selected = "OH"
        selected.should_receive(:selected?).and_return(selected)
        selected.should_receive(:text).and_return("OH")
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:find_elements).and_return([selected])
        selenium_page_object.state.should == "OH"
      end

      it "should set the current item of a select list" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:send_keys).with("OH")
        selenium_page_object.state = "OH"
      end

      it "should retrieve the select list element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.state_element
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
        watir_page_object.should respond_to :active_element
        watir_page_object.should respond_to :active_checkbox
      end

      it "should call a block on the element method when present" do
        block_page_object.active_element.should == "checkbox"
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
        element = watir_page_object.active_element
        element.should be_instance_of PageObject::Elements::CheckBox
      end
    end

    context "Selenium implementation" do
      it "should check a check box element" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(false)
        selenium_browser.should_receive(:click)
        selenium_page_object.check_active
      end

      it "should clear a check box element" do
        selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_browser.should_receive(:click)
        selenium_page_object.uncheck_active
      end

      it "should know if a check box element is selected" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:selected?).and_return(true)
        selenium_page_object.active_checked?.should be_true
      end

      it "should retrieve a checkbox element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.active_element
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
        watir_page_object.should respond_to(:first_element)
        watir_page_object.should respond_to(:first_radio_button)
      end

      it "should call a block on the element method when present" do
        block_page_object.first_element.should == "radio_button"
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
        element = watir_page_object.first_element
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
        element = selenium_page_object.first_element
        element.should be_instance_of PageObject::Elements::RadioButton
      end
    end
  end

  describe "button accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :click_me
        watir_page_object.should respond_to :click_me_element
        watir_page_object.should respond_to :click_me_button
      end

      it "should call a block on the element method when present" do
        block_page_object.click_me_element.should == "button"
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
        element = watir_page_object.click_me_element
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
        element = selenium_page_object.click_me_element
        element.should be_instance_of PageObject::Elements::Button

      end
    end
  end

  describe "div accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:message)
        watir_page_object.should respond_to(:message_element)
        watir_page_object.should respond_to(:message_div)
      end

      it "should call a block on the element method when present" do
        block_page_object.footer_element.should == "div"
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
        element = watir_page_object.message_element
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
        element = selenium_page_object.message_element
        element.should be_instance_of PageObject::Elements::Div

      end
    end
  end

  describe "span accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:alert)
        watir_page_object.should respond_to(:alert_element)
        watir_page_object.should respond_to(:alert_span)
      end

      it "should call a block on the element method when present" do
        block_page_object.alert_element.should == "span"
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
        element = watir_page_object.alert_element
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
        element = selenium_page_object.alert_element
        element.should be_instance_of PageObject::Elements::Span

      end
    end
  end

  describe "table accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:cart_element)
        watir_page_object.should respond_to(:cart_table)
      end

      it "should call a block on the element method when present" do
        block_page_object.cart_element.should == "table"
      end
    end

    context "watir implementation" do
      it "should retrieve the table element from the page" do
        watir_browser.should_receive(:table).and_return(watir_browser)
        element = watir_page_object.cart_element
        element.should be_instance_of PageObject::Elements::Table
      end
    end

    context "selenium implementation" do
      it "should retrieve the table element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.cart_element
        element.should be_instance_of(PageObject::Elements::Table)
      end
    end
  end

  describe "table cell accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:total)
        watir_page_object.should respond_to(:total_element)
        watir_page_object.should respond_to(:total_cell)
      end

      it "should call a block on the element method when present" do
        block_page_object.total_element.should == "cell"
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
        element = watir_page_object.total_element
        element.should be_instance_of PageObject::Elements::TableCell
      end
    end

    context "selenium implementation" do
      it "should retrieve the text from the cell" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return('celldata')
        selenium_page_object.total.should == 'celldata'
      end

      it "should retrieve the cell element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.total_element
        element.should be_instance_of PageObject::Elements::TableCell
      end
    end
  end

  describe "image accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:logo_element)
        watir_page_object.should respond_to(:logo_image)
      end

      it "should call a block on the element method when present" do
        block_page_object.logo_element.should == "image"
      end
    end

    context "watir implementation" do
      it "should retrieve the image element from the page" do
        watir_browser.should_receive(:image).and_return(watir_browser)
        element = watir_page_object.logo_element
        element.should be_instance_of PageObject::Elements::Image
      end
    end

    context "selenium implementation" do
      it "should retrieve the image element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.logo_element
        element.should be_instance_of PageObject::Elements::Image
      end
    end
  end

  describe "form accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:login_element)
        watir_page_object.should respond_to(:login_form)
      end

      it "should call a block on the element method when present" do
        block_page_object.login_element.should == "form"
      end
    end

    context "watir implementation" do
      it "should retrieve the form element from the page" do
        watir_browser.should_receive(:form).and_return(watir_browser)
        element = watir_page_object.login_element
        element.should be_instance_of PageObject::Elements::Form
      end
    end

    context "selenium implementation" do
      it "should retrieve the form element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.login_element
        element.should be_instance_of PageObject::Elements::Form
      end
    end
  end

  describe "list item accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:item_one)
        watir_page_object.should respond_to(:item_one_element)
        watir_page_object.should respond_to(:item_one_list_item)
      end

      it "should call a block on the element method when present" do
        block_page_object.item_one_element.should == "list_item"
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
        element = watir_page_object.item_one_element
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
        element = selenium_page_object.item_one_element
        element.should be_instance_of PageObject::Elements::ListItem
      end
    end
  end

  describe "unordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:menu_element)
        watir_page_object.should respond_to(:menu_unordered_list)
      end

      it "should call a block on the element method when present" do
        block_page_object.menu_element.should == "unordered_list"
      end
    end

    context "watir implementation" do
      it "should retrieve the element from the page" do
        watir_browser.should_receive(:ul).and_return(watir_browser)
        element = watir_page_object.menu_element
        element.should be_instance_of PageObject::Elements::UnorderedList
      end
    end

    context "selenium implementation" do
      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.menu_element
        element.should be_instance_of PageObject::Elements::UnorderedList
      end
    end
  end

  describe "ordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:top_five_element)
        watir_page_object.should respond_to(:top_five_ordered_list)
      end

      it "should call a block on the element method when present" do
        block_page_object.top_five_element.should == "ordered_list"
      end
    end

    context "watir implementation" do
      it "should retrieve the element from the page" do
        watir_browser.should_receive(:ol).and_return(watir_browser)
        element = watir_page_object.top_five_element
        element.should be_instance_of PageObject::Elements::OrderedList
      end
    end

    context "selenium implementation" do
      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.top_five_element
        element.should be_instance_of PageObject::Elements::OrderedList
      end
    end
  end
  
  describe "h1 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:heading1)
        watir_page_object.should respond_to(:heading1_element)
      end
      
      it "should call a block on the element method when present" do
        block_page_object.heading1_element.should == "h1"
      end
    end
    
    context "watir implementation" do
      it "should retrieve the text from the h1" do
        watir_browser.should_receive(:h1).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.heading1.should == "value"        
      end
      
      it "should retrieve the element from the page" do
        watir_browser.should_receive(:h1).and_return(watir_browser)
        element = watir_page_object.heading1_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the text from the h1" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.heading1.should == "value"
      end
      
      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.heading1_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
  end
  
  describe "h2 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:heading2)
        watir_page_object.should respond_to(:heading2_element)
      end
      
      it "should call a block on the element method when present" do
        block_page_object.heading2_element.should == "h2"
      end
    end
    
    context "watir implementation" do
      it "should retrieve the text from the h2" do
        watir_browser.should_receive(:h2).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.heading2.should == "value"        
      end
      
      it "should retrieve the element from the page" do
        watir_browser.should_receive(:h2).and_return(watir_browser)
        element = watir_page_object.heading2_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
    
    context "selenium implementation" do
      it "should retrieve the text from the h2" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.heading2.should == "value"
      end
      
      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.heading2_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
  end

  describe "h3 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:heading3)
        watir_page_object.should respond_to(:heading3_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.heading3_element.should == "h3"
      end
    end

    context "watir implementation" do
      it "should retrieve the text from the h3" do
        watir_browser.should_receive(:h3).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.heading3.should == "value"        
      end

      it "should retrieve the element from the page" do
        watir_browser.should_receive(:h3).and_return(watir_browser)
        element = watir_page_object.heading3_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end

    context "selenium implementation" do
      it "should retrieve the text from the h3" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.heading3.should == "value"
      end

      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.heading3_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
  end

  describe "h4 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:heading4)
        watir_page_object.should respond_to(:heading4_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.heading4_element.should == "h4"
      end
    end

    context "watir implementation" do
      it "should retrieve the text from the h4" do
        watir_browser.should_receive(:h4).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.heading4.should == "value"        
      end

      it "should retrieve the element from the page" do
        watir_browser.should_receive(:h4).and_return(watir_browser)
        element = watir_page_object.heading4_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end

    context "selenium implementation" do
      it "should retrieve the text from the h4" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.heading4.should == "value"
      end

      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.heading4_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
  end

  describe "h5 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:heading5)
        watir_page_object.should respond_to(:heading5_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.heading5_element.should == "h5"
      end
    end

    context "watir implementation" do
      it "should retrieve the text from the h5" do
        watir_browser.should_receive(:h5).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.heading5.should == "value"        
      end

      it "should retrieve the element from the page" do
        watir_browser.should_receive(:h5).and_return(watir_browser)
        element = watir_page_object.heading5_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end

    context "selenium implementation" do
      it "should retrieve the text from the h5" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.heading5.should == "value"
      end

      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.heading5_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
  end

  describe "h6 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:heading6)
        watir_page_object.should respond_to(:heading6_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.heading6_element.should == "h6"
      end
    end

    context "watir implementation" do
      it "should retrieve the text from the h6" do
        watir_browser.should_receive(:h6).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.heading6.should == "value"        
      end

      it "should retrieve the element from the page" do
        watir_browser.should_receive(:h6).and_return(watir_browser)
        element = watir_page_object.heading6_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end

    context "selenium implementation" do
      it "should retrieve the text from the h6" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.heading6.should == "value"
      end

      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.heading6_element
        element.should be_instance_of PageObject::Elements::Heading
      end
    end
  end


  describe "p accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:first_para)
        watir_page_object.should respond_to(:first_para_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.first_para_element.should == "p"
      end
    end

    context "watir implementation" do
      it "should retrieve the text from the p" do
        watir_browser.should_receive(:p).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return("value")
        watir_page_object.first_para.should == "value"        
      end

      it "should retrieve the element from the page" do
        watir_browser.should_receive(:p).and_return(watir_browser)
        element = watir_page_object.first_para_element
        element.should be_instance_of PageObject::Elements::Paragraph
      end
    end

    context "selenium implementation" do
      it "should retrieve the text from the p" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:text).and_return("value")
        selenium_page_object.first_para.should == "value"
      end

      it "should retrieve the element from the page" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.first_para_element
        element.should be_instance_of PageObject::Elements::Paragraph
      end
    end
  end

  describe "file_field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:upload_me=)
        watir_page_object.should respond_to(:upload_me_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.a_file_element.should == "file_field"
      end
    end

    context "watir implementation" do
      it "should set the file name" do
        watir_browser.should_receive(:file_field).and_return(watir_browser)
        watir_browser.should_receive(:set).with('some_file')
        watir_page_object.upload_me = 'some_file'
      end

      it "should retrieve a text field element" do
        watir_browser.should_receive(:file_field).and_return(watir_browser)
        element = watir_page_object.upload_me_element
        element.should be_instance_of PageObject::Elements::FileField
      end
    end

    context "selenium implementation" do
      it "should set the file name" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        selenium_browser.should_receive(:send_keys).with('some_file')
        selenium_page_object.upload_me = 'some_file'
      end

      it "should retrieve a file_field element" do
        selenium_browser.should_receive(:find_element).and_return(selenium_browser)
        element = selenium_page_object.upload_me_element
        element.should be_instance_of PageObject::Elements::FileField
      end
    end
  end
end
