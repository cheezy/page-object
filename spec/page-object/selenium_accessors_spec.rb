require 'spec_helper'

class SeleniumAccessorsTestPageObject
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
  span(:alert_span, :id => 'alert_id')
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
  canvas(:my_canvas, :id => 'canvas')
  audio(:acdc, :id => 'audio_id')
  video(:movie, :id => 'movie_id')
  b(:bold, :id => 'bold')
  i(:italic, :id => 'italic')
end

class SeleniumBlockPageObject
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
  span :alert_span do |element|
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
    'audio'
  end
  video :movie do |element|
    'video'
  end

  b :bold do |element|
    'b'
  end

  i :italic do |element|
    'i'
  end
end

describe PageObject::Accessors do
  let(:selenium_browser) { mock_selenium_browser }
  let(:selenium_page_object) { SeleniumAccessorsTestPageObject.new(selenium_browser) }
  let(:block_page_object) { SeleniumBlockPageObject.new(selenium_browser) }

  before(:each) do
    allow(selenium_browser).to receive(:switch_to).and_return(selenium_browser)
    allow(selenium_browser).to receive(:default_content)
  end

  describe "link accessors" do
    it "should select a link" do
      allow(selenium_browser).to receive_messages(find_element: selenium_browser, click: selenium_browser)
      selenium_page_object.google_search
    end

    it "should return a link element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.google_search_element
      expect(element).to be_instance_of PageObject::Elements::Link
    end
  end


  describe "text_field accessors" do
    it "should get the text from the text field element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:attribute).with('value').and_return('Katie')
      expect(selenium_page_object.first_name).to eql 'Katie'
    end

    it "should set some text on a text field element" do
      expect(selenium_browser).to receive(:find_element).twice.and_return(selenium_browser)
      expect(selenium_browser).to receive(:clear)
      expect(selenium_browser).to receive(:send_keys).with('Katie')
      selenium_page_object.first_name = 'Katie'
    end

    it "should retrieve a text field element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.first_name_element
      expect(element).to be_instance_of PageObject::Elements::TextField
    end
  end


  describe "hidden field accessors" do
    it "should get the text from a hidden field" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:attribute).with('value').and_return("12345")
      expect(selenium_page_object.social_security_number).to eql "12345"
    end

    it "should retrieve a hidden field element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.social_security_number_element
      expect(element).to be_instance_of PageObject::Elements::HiddenField
    end
  end

  describe "text area accessors" do
    it "should set some text on the text area" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:clear)
      expect(selenium_browser).to receive(:send_keys).with("123 main street")
      selenium_page_object.address = "123 main street"
    end

    it "should get the text from the text area" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:attribute).with('value').and_return("123 main street")
      expect(selenium_page_object.address).to eql "123 main street"
    end

    it "should retrieve a text area element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.address_element
      expect(element).to be_instance_of PageObject::Elements::TextArea
    end
  end

  describe "select_list accessors" do
    it "should should get the current item from a select list" do
      selected = "OH"
      expect(selected).to receive(:selected?).and_return(selected)
      expect(selected).to receive(:text).and_return("OH")
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:find_elements).and_return([selected])
      expect(selenium_page_object.state).to eql "OH"
    end

    it "should set the current item of a select list" do
      option = double('option')
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:find_elements).and_return([option])
      expect(option).to receive(:text).and_return('OH')
      expect(option).to receive(:click)
      selenium_page_object.state = "OH"
    end

    it "should retrieve the select list element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.state_element
      expect(element).to be_instance_of PageObject::Elements::SelectList
    end

    it "should return list of selection options" do
      option1 = double('option')
      option2 = double('option')
      expect(option1).to receive(:text).and_return("CA")
      expect(option2).to receive(:text).and_return("OH")

      select_element = double("select")
      expect(select_element).to receive(:options).twice.and_return([option1, option2])
      expect(selenium_page_object).to receive(:state_element).and_return(select_element)

      expect(selenium_page_object.state_options).to eql ["CA","OH"]
    end

  end


  describe "check_box accessors" do
    it "should check a check box element" do
      expect(selenium_browser).to receive(:find_element).twice.and_return(selenium_browser)
      expect(selenium_browser).to receive(:selected?).and_return(false)
      expect(selenium_browser).to receive(:click)
      selenium_page_object.check_active
    end

    it "should clear a check box element" do
      expect(selenium_browser).to receive(:find_element).twice.and_return(selenium_browser)
      expect(selenium_browser).to receive(:selected?).and_return(true)
      expect(selenium_browser).to receive(:click)
      selenium_page_object.uncheck_active
    end

    it "should know if a check box element is selected" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:selected?).and_return(true)
      expect(selenium_page_object.active_checked?).to be true
    end

    it "should retrieve a checkbox element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.active_element
      expect(element).to be_instance_of PageObject::Elements::CheckBox
    end
  end


  describe "radio accessors" do
    it "should select a radio button" do
      expect(selenium_browser).to receive(:find_element).twice.and_return(selenium_browser)
      expect(selenium_browser).to receive(:selected?).and_return(false)
      expect(selenium_browser).to receive(:click)
      selenium_page_object.select_first
    end

    it "should determine if a radio is selected" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:selected?).and_return(true)
      selenium_page_object.first_selected?
    end

    it "should retrieve a radio button element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.first_element
      expect(element).to be_instance_of PageObject::Elements::RadioButton
    end
  end

  describe "button accessors" do
    it "should be able to click a button" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:click)
      selenium_page_object.click_me
    end

    it "should retrieve a button element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.click_me_element
      expect(element).to be_instance_of PageObject::Elements::Button
    end
  end

  describe "div accessors" do
    it "should retrieve the text from a div" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("Message from div")
      expect(selenium_page_object.message).to eql "Message from div"
    end

    it "should retrieve the div element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.message_element
      expect(element).to be_instance_of PageObject::Elements::Div
    end
  end

  describe "span accessors" do
    it "should retrieve the text from a span" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("Alert")
      expect(selenium_page_object.alert_span).to eql "Alert"
    end

    it "should retrieve the span element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.alert_span_element
      expect(element).to be_instance_of PageObject::Elements::Span
    end
  end

  describe "table accessors" do
    it "should retrieve the table element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.cart_element
      expect(element).to be_instance_of(PageObject::Elements::Table)
    end
  end

  describe "table cell accessors" do
    it "should retrieve the text from the cell" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return('celldata')
      expect(selenium_page_object.total).to eql 'celldata'
    end

    it "should retrieve the cell element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.total_element
      expect(element).to be_instance_of PageObject::Elements::TableCell
    end
  end

  describe "image accessors" do
    it "should retrieve the image element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.logo_element
      expect(element).to be_instance_of PageObject::Elements::Image
    end
  end

  describe "form accessors" do
    it "should retrieve the form element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.login_element
      expect(element).to be_instance_of PageObject::Elements::Form
    end
  end

  describe "list item accessors" do
    it "should retrieve the text from the list item" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.item_one).to eql "value"
    end

    it "should retrieve the list item from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.item_one_element
      expect(element).to be_instance_of PageObject::Elements::ListItem
    end
  end

  describe "unordered list accessors" do
    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.menu_element
      expect(element).to be_instance_of PageObject::Elements::UnorderedList
    end
  end

  describe "ordered list accessors" do
    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.top_five_element
      expect(element).to be_instance_of PageObject::Elements::OrderedList
    end
  end

  describe "h1 accessors" do
    it "should retrieve the text from the h1" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.heading1).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.heading1_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h2 accessors" do
    it "should retrieve the text from the h2" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.heading2).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.heading2_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h3 accessors" do
    it "should retrieve the text from the h3" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.heading3).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.heading3_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h4 accessors" do
    it "should retrieve the text from the h4" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.heading4).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.heading4_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h5 accessors" do
    it "should retrieve the text from the h5" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.heading5).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.heading5_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h6 accessors" do
    it "should retrieve the text from the h6" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.heading6).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.heading6_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end


  describe "p accessors" do
    it "should retrieve the text from the p" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.first_para).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.first_para_element
      expect(element).to be_instance_of PageObject::Elements::Paragraph
    end
  end

  describe "file_field accessors" do
    it "should set the file name" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:send_keys).with('some_file')
      selenium_page_object.upload_me = 'some_file'
    end

    it "should retrieve a file_field element" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.upload_me_element
      expect(element).to be_instance_of PageObject::Elements::FileField
    end
  end

  describe "area accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(selenium_page_object).to respond_to(:img_area)
        expect(selenium_page_object).to respond_to(:img_area_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.img_area_element).to eql "area"
      end
    end

    it "should click on the area" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:click)
      selenium_page_object.img_area
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.img_area_element
      expect(element).to be_instance_of PageObject::Elements::Area
    end
  end

  describe "canvas accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(selenium_page_object).to respond_to(:my_canvas_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.my_canvas_element).to eql "canvas"
      end
    end
  end

  describe "audio accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(selenium_page_object).to respond_to(:acdc_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.acdc_element).to eql "audio"
      end
    end
  end

  describe "video accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(selenium_page_object).to respond_to(:movie_element)
      end

      it "should call a block on the elmenet method when present" do
        expect(block_page_object.movie_element).to eql "video"
      end
    end
  end

  describe "b accessors" do
    it "should retrieve the text from the b" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.bold).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.bold_element
      expect(element).to be_instance_of PageObject::Elements::Bold
    end
  end

  describe "i accessors" do
    it "should retrieve the text from the i" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      expect(selenium_browser).to receive(:text).and_return("value")
      expect(selenium_page_object.italic).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(selenium_browser).to receive(:find_element).and_return(selenium_browser)
      element = selenium_page_object.italic_element
      expect(element).to be_instance_of PageObject::Elements::Italic
    end
  end

end
