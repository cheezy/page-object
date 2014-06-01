require 'spec_helper'

class WatirAccessorsTestPageObject
  include PageObject

  page_url "http://apple.com"
  expected_title "Expected Title"
  expected_element :google_search
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
  area(:img_area, :id => 'area')
  canvas(:my_canvas, :id => 'canvas_id')
  audio(:acdc, :id => 'audio_id')
  video(:movie, :id => 'video_id')
end

class WatirBlockPageObject
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
  area :img_area do |element|
    "area"
  end
  canvas :my_canvas do |element|
    "canvas"
  end
  audio :acdc do |element|
    "audio"
  end
  video :movie do |element|
    "video"
  end
end

describe PageObject::Accessors do
  let(:watir_browser) { mock_watir_browser }
  let(:watir_page_object) { WatirAccessorsTestPageObject.new(watir_browser) }
  let(:block_page_object) { WatirBlockPageObject.new(watir_browser) }

  context "goto a page" do

    it "should navigate to a page when requested" do
      watir_browser.should_receive(:goto)
      WatirAccessorsTestPageObject.new(watir_browser, true)
    end

    it "should call a method when page_url called with a symbol" do
      class SymbolPageUrl
        include PageObject
        page_url :custom_url

        attr_reader :custom_url
        def initialize(b, v, url)
          @custom_url = url
          super(b, v)
        end
      end
      watir_browser.should_receive(:goto).with('custom')
      SymbolPageUrl.new(watir_browser, true, 'custom')

      watir_browser.should_receive(:goto).with('different')
      SymbolPageUrl.new(watir_browser, true, 'different')      
    end

    it "should not navigate to a page when not requested" do
      watir_browser.should_not_receive(:goto)
      WatirAccessorsTestPageObject.new(watir_browser)
    end

    it "should not navigate to a page when 'page_url' not specified" do
      watir_browser.should_not_receive(:goto)
      WatirBlockPageObject.new(watir_browser, true)
    end

    it "should provide the page url" do
      watir_page_object.page_url_value.should == 'http://apple.com'
    end
  end

  context "validating the page title" do
    it "should validate the title" do
      watir_browser.should_receive(:title).and_return("Expected Title")
      watir_page_object.should have_expected_title
    end

    it "should validate the by regexp" do
      class RegexpExpectedTitle
        include PageObject
        expected_title /\w+ \w+/
      end
      watir_browser.should_receive(:title).and_return("Expected Title")
      RegexpExpectedTitle.new(watir_browser).should have_expected_title
    end

    it "should raise error when it does not have expected title" do
      watir_browser.should_receive(:title).once.and_return("Not Expected")
      expect { watir_page_object.has_expected_title? }.to raise_error
    end
  end

  context "validating the existence of an element" do
    it "should validate an element exists" do
      watir_page_object.should_receive(:google_search_element).and_return(watir_browser)
      watir_browser.should_receive(:when_present).and_return(true)
      watir_page_object.has_expected_element?
    end

    it "should handle non-existent elements gracefully" do
      class FakePage
        include PageObject
        expected_element :foo
      end
      FakePage.new(watir_browser).should_not have_expected_element
    end
  end

  context "using default identifiers" do
    class WatirDefaultIdentifier
      include PageObject
      text_field(:default_tf)
      hidden_field(:default_hf)
      text_area(:default_ta)
      select_list(:default_sl)
      link(:default_link)
      checkbox(:default_cb)
      radio_button(:default_rb)
      button(:default_but)
      div(:default_div)
      span(:default_span)
      table(:default_tab)
      cell(:default_cell)
      image(:default_im)
      form(:default_form)
      list_item(:default_li)
      unordered_list(:default_ul)
      ordered_list(:default_ol)
      h1(:default_h1)
      h2(:default_h2)
      h3(:default_h3)
      h4(:default_h4)
      h5(:default_h5)
      h6(:default_h6)
      paragraph(:default_p)
      file_field(:default_ff)
      label(:default_lab)
      element(:default_el, :audio)
    end

    let(:default_identifier) { WatirDefaultIdentifier.new(watir_browser) }

    def mock_driver_for(tag)
      watir_browser.should_receive(tag).with(:index => 0).and_return(watir_browser)
    end

    it "should work with a text_field" do
      mock_driver_for :text_field
      default_identifier.default_tf?
    end

    it "should work with a hidden field" do
      mock_driver_for :hidden
      default_identifier.default_hf?
    end

    it "should work with a text area" do
      mock_driver_for :textarea
      default_identifier.default_ta?
    end

    it "should work with a select list" do
      mock_driver_for :select_list
      default_identifier.default_sl?
    end

    it "should work with a link" do
      mock_driver_for :link
      default_identifier.default_link?
    end

    it "should work with a checkbox" do
      mock_driver_for :checkbox
      default_identifier.default_cb?
    end

    it "should work with a radio button" do
      mock_driver_for :radio
      default_identifier.default_rb?
    end

    it "should work with a button" do
      mock_driver_for :button
      default_identifier.default_but?
    end

    it "should work with a div" do
      mock_driver_for :div
      default_identifier.default_div?
    end

    it "should work with a span" do
      mock_driver_for :span
      default_identifier.default_span?
    end

    it "should work for a table" do
      mock_driver_for :table
      default_identifier.default_tab_element.should_not be_nil
    end

    it "should work for a cell" do
      mock_driver_for :td
      default_identifier.default_cell?
    end

    it "should work for an image" do
      mock_driver_for :image
      default_identifier.default_im?
    end

    it "should work for a form" do
      mock_driver_for :form
      default_identifier.default_form?
    end

    it "should work for a list item" do
      mock_driver_for :li
      default_identifier.default_li?
    end

    it "should work for unordered lists" do
      mock_driver_for :ul
      default_identifier.default_ul?
    end

    it "should work for ordered lists" do
      mock_driver_for :ol
      default_identifier.default_ol?
    end

    it "should work for h1" do
      mock_driver_for :h1
      default_identifier.default_h1?
    end

    it "should work for h2" do
      mock_driver_for :h2
      default_identifier.default_h2?
    end

    it "should work for h3" do
      mock_driver_for :h3
      default_identifier.default_h3?
    end

    it "should work for a h4" do
      mock_driver_for :h4
      default_identifier.default_h4?
    end

    it "should work for a h5" do
      mock_driver_for :h5
      default_identifier.default_h5?
    end

    it "should work for a h6" do
      mock_driver_for :h6
      default_identifier.default_h6?
    end

    it "should work with a paragraph" do
      mock_driver_for :p
      default_identifier.default_p?
    end

    it "should work with a file_field" do
      mock_driver_for :file_field
      default_identifier.default_ff?
    end

    it "should work with a label" do
      mock_driver_for :label
      default_identifier.default_lab?
    end

    it "should work with an element" do
      mock_driver_for :audio
      default_identifier.default_el?
    end

  end

  context "link accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:google_search)
        watir_page_object.should respond_to(:google_search_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.continue_element.should == "link"
      end
    end

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


  describe "text_field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:first_name)
        watir_page_object.should respond_to(:first_name=)
        watir_page_object.should respond_to(:first_name_element)
        watir_page_object.should respond_to(:first_name?)
      end

      it "should call a block on the element method when present" do
        block_page_object.first_name_element.should == "text_field"
      end
    end

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


  describe "hidden field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:social_security_number)
        watir_page_object.should respond_to(:social_security_number_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.secret_element.should == "hidden_field"
      end
    end

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

  describe "text area accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:address)
        watir_page_object.should respond_to(:address=)
        watir_page_object.should respond_to(:address_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.address_element.should == "text_area"
      end
    end

    it "should set some text on the text area" do
      watir_browser.should_receive(:textarea).and_return(watir_browser)
      watir_browser.should_receive(:set).with("123 main street")
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

  describe "select_list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :state
        watir_page_object.should respond_to :state=
        watir_page_object.should respond_to(:state_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.state_element.should == "select_list"
      end
    end

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
    
    it "should return list of selection options" do
      option1 = double('option')
      option2 = double('option')
      option1.should_receive(:text).and_return("CA")
      option2.should_receive(:text).and_return("OH")

      select_element = double("select")
      select_element.should_receive(:options).twice.and_return([option1, option2])
      watir_page_object.should_receive(:state_element).and_return(select_element)
      
      watir_page_object.state_options.should == ["CA","OH"]
    end
    
    
  end


  describe "check_box accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :check_active
        watir_page_object.should respond_to :uncheck_active
        watir_page_object.should respond_to :active_checked?
        watir_page_object.should respond_to :active_element
      end

      it "should call a block on the element method when present" do
        block_page_object.active_element.should == "checkbox"
      end
    end

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
      watir_page_object.active_checked?.should be true
    end

    it "should retrieve a checkbox element" do
      watir_browser.should_receive(:checkbox).and_return(watir_browser)
      element = watir_page_object.active_element
      element.should be_instance_of PageObject::Elements::CheckBox
    end
  end


  describe "radio accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :select_first
        watir_page_object.should respond_to :clear_first
        watir_page_object.should respond_to :first_selected?
        watir_page_object.should respond_to(:first_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.first_element.should == "radio_button"
      end
    end

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

  describe "button accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to :click_me
        watir_page_object.should respond_to :click_me_element
      end

      it "should call a block on the element method when present" do
        block_page_object.click_me_element.should == "button"
      end
    end

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

  describe "div accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:message)
        watir_page_object.should respond_to(:message_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.footer_element.should == "div"
      end
    end

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

  describe "span accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:alert)
        watir_page_object.should respond_to(:alert_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.alert_element.should == "span"
      end
    end

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

  describe "table accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:cart)
        watir_page_object.should respond_to(:cart_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.cart_element.should == "table"
      end
    end

    it "should retrieve the table element from the page" do
      watir_browser.should_receive(:table).and_return(watir_browser)
      element = watir_page_object.cart_element
      element.should be_instance_of PageObject::Elements::Table
    end
  end

  describe "table cell accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:total)
        watir_page_object.should respond_to(:total_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.total_element.should == "cell"
      end
    end

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

  describe "image accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:logo_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.logo_element.should == "image"
      end
    end

    it "should retrieve the image element from the page" do
      watir_browser.should_receive(:image).and_return(watir_browser)
      element = watir_page_object.logo_element
      element.should be_instance_of PageObject::Elements::Image
    end
  end

  describe "form accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:login_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.login_element.should == "form"
      end
    end

    it "should retrieve the form element from the page" do
      watir_browser.should_receive(:form).and_return(watir_browser)
      element = watir_page_object.login_element
      element.should be_instance_of PageObject::Elements::Form
    end
  end

  describe "list item accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:item_one)
        watir_page_object.should respond_to(:item_one_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.item_one_element.should == "list_item"
      end
    end

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

  describe "unordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:menu_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.menu_element.should == "unordered_list"
      end
    end

    it "should retrieve the element from the page" do
      watir_browser.should_receive(:ul).and_return(watir_browser)
      element = watir_page_object.menu_element
      element.should be_instance_of PageObject::Elements::UnorderedList
    end
  end

  describe "ordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:top_five_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.top_five_element.should == "ordered_list"
      end
    end

    it "should retrieve the element from the page" do
      watir_browser.should_receive(:ol).and_return(watir_browser)
      element = watir_page_object.top_five_element
      element.should be_instance_of PageObject::Elements::OrderedList
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

  describe "area accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:img_area)
        watir_page_object.should respond_to(:img_area_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.img_area_element.should == "area"
      end
    end

    it "should click on the area" do
      watir_browser.should_receive(:area).and_return(watir_browser)
      watir_browser.should_receive(:click)
      watir_page_object.img_area
    end

    it "should retrieve the element from the page" do
      watir_browser.should_receive(:area).and_return(watir_browser)
      element = watir_page_object.img_area_element
      element.should be_instance_of PageObject::Elements::Area
    end
  end

  describe "canvas accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:my_canvas_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.my_canvas_element.should == "canvas"
      end
    end
  end
  
  describe "audio accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:acdc_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.acdc_element.should == "audio"
      end
    end
  end

  describe "video accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        watir_page_object.should respond_to(:movie_element)
      end

      it "should call a block on the element method when present" do
        block_page_object.movie_element.should == "video"
      end
    end
  end
end
