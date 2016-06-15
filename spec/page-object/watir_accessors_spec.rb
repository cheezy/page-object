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
  canvas(:my_canvas, :id => 'canvas_id')
  audio(:acdc, :id => 'audio_id')
  video(:movie, :id => 'video_id')
  b(:bold, :id => 'bold')
  i(:italic, :id => 'italic')
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
    "audio"
  end
  video :movie do |element|
    "video"
  end
  b :bold do |element|
    "b"
  end
  i :italic do |element|
    "i"
  end
end

describe PageObject::Accessors do
  let(:watir_browser) { mock_watir_browser }
  let(:watir_page_object) { WatirAccessorsTestPageObject.new(watir_browser) }
  let(:block_page_object) { WatirBlockPageObject.new(watir_browser) }

  context "goto a page" do

    it "should navigate to a page when requested" do
      expect(watir_browser).to receive(:goto)
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
      expect(watir_browser).to receive(:goto).with('custom')
      SymbolPageUrl.new(watir_browser, true, 'custom')

      expect(watir_browser).to receive(:goto).with('different')
      SymbolPageUrl.new(watir_browser, true, 'different')
    end

    it "should not navigate to a page when not requested" do
      expect(watir_browser).not_to receive(:goto)
      WatirAccessorsTestPageObject.new(watir_browser)
    end

    it "should not navigate to a page when 'page_url' not specified" do
      expect(watir_browser).not_to receive(:goto)
      WatirBlockPageObject.new(watir_browser, true)
    end

    it "should provide the page url" do
      expect(watir_page_object.page_url_value).to eql 'http://apple.com'
    end
  end

  context "validating the page title" do
    it "should validate the title" do
      expect(watir_browser).to receive(:title).and_return("Expected Title")
      expect(watir_page_object).to have_expected_title
    end

    it "should validate the by regexp" do
      class RegexpExpectedTitle
        include PageObject
        expected_title /\w+ \w+/
      end
      expect(watir_browser).to receive(:title).and_return("Expected Title")
      expect(RegexpExpectedTitle.new(watir_browser)).to have_expected_title
    end

    it "should raise error when it does not have expected title" do
      expect(watir_browser).to receive(:title).once.and_return("Not Expected")
      expect { watir_page_object.has_expected_title? }.to raise_error
    end
  end

  context "validating the existence of an element" do
    it "should validate an element exists" do
      expect(watir_page_object).to receive(:google_search_element).and_return(watir_browser)
      expect(watir_browser).to receive(:when_present).and_return(true)
      watir_page_object.has_expected_element?
    end

    it "should handle non-existent elements gracefully" do
      class FakePage
        include PageObject
        expected_element :foo
      end
      expect(FakePage.new(watir_browser)).not_to have_expected_element
    end
  end

  context "using element accessor" do
    class WatirDefaultElementTagToElement
      include PageObject
      # verify that the explicit :element tag can be omitted
      # element('button', :element, {:css => 'some css'})
      element('button', { :css => 'some css' })
      elements('button2', { :css => 'some css' })
    end

    let (:page) { WatirDefaultElementTagToElement.new(watir_browser) }

    def mock_driver_for(tag)
      expect(watir_browser).to receive(tag).with(:css => 'some css').and_return(watir_browser)
    end

    it "should default element tag to element" do
      mock_driver_for :element
      page.button_element
    end

    it "should default elements tag to element" do
      mock_driver_for :elements
      expect(watir_browser).to receive(:map).and_return([])
      page.button2_elements.to_a
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
      expect(watir_browser).to receive(tag).with(:index => 0).and_return(watir_browser)
      allow(watir_browser).to receive(:exists?).with(no_args)
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
      expect(default_identifier.default_tab_element).not_to be_nil
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
        expect(watir_page_object).to respond_to(:google_search)
        expect(watir_page_object).to respond_to(:google_search_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.continue_element).to eql "link"
      end
    end

    it "should select a link" do
      expect(watir_browser).to receive_messages(link: watir_browser, click: watir_browser)
      watir_page_object.google_search
    end

    it "should return a link element" do
      expect(watir_browser).to receive(:link).and_return(watir_browser)
      element = watir_page_object.google_search_element
      expect(element).to be_instance_of PageObject::Elements::Link
    end
  end


  describe "text_field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:first_name)
        expect(watir_page_object).to respond_to(:first_name=)
        expect(watir_page_object).to respond_to(:first_name_element)
        expect(watir_page_object).to respond_to(:first_name?)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.first_name_element).to eql "text_field"
      end
    end

    it "should get the text from the text field element" do
      expect(watir_browser).to receive(:text_field).and_return(watir_browser)
      expect(watir_browser).to receive(:value).and_return('Kim')
      expect(watir_page_object.first_name).to eql 'Kim'
    end

    it "should set some text on a text field element" do
      expect(watir_browser).to receive(:text_field).and_return(watir_browser)
      expect(watir_browser).to receive(:set).with('Kim')
      watir_page_object.first_name = 'Kim'
    end

    it "should retrieve a text field element" do
      expect(watir_browser).to receive(:text_field).and_return(watir_browser)
      element = watir_page_object.first_name_element
      expect(element).to be_instance_of PageObject::Elements::TextField
    end
  end


  describe "hidden field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:social_security_number)
        expect(watir_page_object).to respond_to(:social_security_number_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.secret_element).to eql "hidden_field"
      end
    end

    it "should get the text from a hidden field" do
      expect(watir_browser).to receive(:hidden).and_return(watir_browser)
      expect(watir_browser).to receive(:value).and_return("value")
      expect(watir_page_object.social_security_number).to eql "value"
    end

    it "should retrieve a hidden field element" do
      expect(watir_browser).to receive(:hidden).and_return(watir_browser)
      element = watir_page_object.social_security_number_element
      expect(element).to be_instance_of(PageObject::Elements::HiddenField)
    end
  end

  describe "text area accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:address)
        expect(watir_page_object).to respond_to(:address=)
        expect(watir_page_object).to respond_to(:address_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.address_element).to eql "text_area"
      end
    end

    it "should set some text on the text area" do
      expect(watir_browser).to receive(:textarea).and_return(watir_browser)
      expect(watir_browser).to receive(:set).with("123 main street")
      watir_page_object.address = "123 main street"
    end

    it "should get the text from the text area" do
      expect(watir_browser).to receive(:textarea).and_return(watir_browser)
      expect(watir_browser).to receive(:value).and_return("123 main street")
      expect(watir_page_object.address).to eql "123 main street"
    end

    it "should retrieve a text area element" do
      expect(watir_browser).to receive(:textarea).and_return(watir_browser)
      element = watir_page_object.address_element
      expect(element).to be_instance_of PageObject::Elements::TextArea
    end
  end

  describe "select_list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to :state
        expect(watir_page_object).to respond_to :state=
        expect(watir_page_object).to respond_to(:state_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.state_element).to eql "select_list"
      end
    end

    it "should get the current item from a select list" do
      selected = "OH"
      expect(selected).to receive(:selected?).and_return(selected)
      expect(selected).to receive(:text).and_return("OH")
      expect(watir_browser).to receive(:select_list).and_return watir_browser
      expect(watir_browser).to receive(:options).and_return([selected])
      expect(watir_page_object.state).to eql "OH"
    end

    it "should set the current item of a select list" do
      expect(watir_browser).to receive(:select_list).and_return watir_browser
      expect(watir_browser).to receive(:select).with("OH")
      watir_page_object.state = "OH"
    end

    it "should retreive the select list element" do
      expect(watir_browser).to receive(:select_list).and_return(watir_browser)
      element = watir_page_object.state_element
      expect(element).to be_instance_of PageObject::Elements::SelectList
    end

    it "should return list of selection options" do
      option1 = double('option')
      option2 = double('option')
      expect(option1).to receive(:text).and_return("CA")
      expect(option2).to receive(:text).and_return("OH")

      select_element = double("select")
      expect(select_element).to receive(:options).twice.and_return([option1, option2])
      expect(watir_page_object).to receive(:state_element).and_return(select_element)

      expect(watir_page_object.state_options).to eql ["CA","OH"]
    end
  end

  describe "check_box accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to :check_active
        expect(watir_page_object).to respond_to :uncheck_active
        expect(watir_page_object).to respond_to :active_checked?
        expect(watir_page_object).to respond_to :active_element
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.active_element).to eql "checkbox"
      end
    end

    it "should check a check box element" do
      expect(watir_browser).to receive(:checkbox).and_return(watir_browser)
      expect(watir_browser).to receive(:set)
      watir_page_object.check_active
    end

    it "should clear a check box element" do
      expect(watir_browser).to receive(:checkbox).and_return(watir_browser)
      expect(watir_browser).to receive(:clear)
      watir_page_object.uncheck_active
    end

    it "should know if a check box element is selected" do
      expect(watir_browser).to receive(:checkbox).and_return(watir_browser)
      expect(watir_browser).to receive(:set?).and_return(true)
      expect(watir_page_object.active_checked?).to be true
    end

    it "should retrieve a checkbox element" do
      expect(watir_browser).to receive(:checkbox).and_return(watir_browser)
      element = watir_page_object.active_element
      expect(element).to be_instance_of PageObject::Elements::CheckBox
    end
  end


  describe "radio accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to :select_first
        expect(watir_page_object).to respond_to :first_selected?
        expect(watir_page_object).to respond_to(:first_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.first_element).to eql "radio_button"
      end
    end

    it "should select a radio button" do
      expect(watir_browser).to receive(:radio).and_return(watir_browser)
      expect(watir_browser).to receive(:set)
      watir_page_object.select_first
    end

    it "should determine if a radio is selected" do
      expect(watir_browser).to receive(:radio).and_return(watir_browser)
      expect(watir_browser).to receive(:set?)
      watir_page_object.first_selected?
    end

    it "should retrieve a radio button element" do
      expect(watir_browser).to receive(:radio).and_return(watir_browser)
      element = watir_page_object.first_element
      expect(element).to be_instance_of PageObject::Elements::RadioButton
    end
  end

  describe "button accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to :click_me
        expect(watir_page_object).to respond_to :click_me_element
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.click_me_element).to eql "button"
      end
    end

    it "should be able to click a button" do
      expect(watir_browser).to receive(:button).and_return(watir_browser)
      expect(watir_browser).to receive(:click)
      watir_page_object.click_me
    end

    it "should retrieve a button element" do
      expect(watir_browser).to receive(:button).and_return(watir_browser)
      element = watir_page_object.click_me_element
      expect(element).to be_instance_of PageObject::Elements::Button
    end
  end

  describe "div accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:message)
        expect(watir_page_object).to respond_to(:message_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.footer_element).to eql "div"
      end
    end

    it "should retrieve the text from a div" do
      expect(watir_browser).to receive(:div).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("Message from div")
      expect(watir_page_object.message).to eql "Message from div"
    end

    it "should retrieve the div element from the page" do
      expect(watir_browser).to receive(:div).and_return(watir_browser)
      element = watir_page_object.message_element
      expect(element).to be_instance_of PageObject::Elements::Div
    end
  end

  describe "span accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:alert_span)
        expect(watir_page_object).to respond_to(:alert_span_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.alert_span_element).to eql "span"
      end
    end

    it "should retrieve the text from a span" do
      expect(watir_browser).to receive(:span).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("Alert")
      expect(watir_page_object.alert_span).to eql "Alert"
    end

    it "should retrieve the span element from the page" do
      expect(watir_browser).to receive(:span).and_return(watir_browser)
      element = watir_page_object.alert_span_element
      expect(element).to be_instance_of PageObject::Elements::Span
    end
  end

  describe "table accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:cart)
        expect(watir_page_object).to respond_to(:cart_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.cart_element).to eql "table"
      end
    end

    it "should retrieve the table element from the page" do
      expect(watir_browser).to receive(:table).and_return(watir_browser)
      element = watir_page_object.cart_element
      expect(element).to be_instance_of PageObject::Elements::Table
    end
  end

  describe "table cell accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:total)
        expect(watir_page_object).to respond_to(:total_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.total_element).to eql "cell"
      end
    end

    it "should retrieve the text for the cell" do
      expect(watir_browser).to receive(:td).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return('10.00')
      expect(watir_page_object.total).to eql '10.00'
    end

    it "should retrieve the cell element from the page" do
      expect(watir_browser).to receive(:td).and_return(watir_browser)
      element = watir_page_object.total_element
      expect(element).to be_instance_of PageObject::Elements::TableCell
    end
  end

  describe "image accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:logo_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.logo_element).to eql "image"
      end
    end

    it "should retrieve the image element from the page" do
      expect(watir_browser).to receive(:image).and_return(watir_browser)
      element = watir_page_object.logo_element
      expect(element).to be_instance_of PageObject::Elements::Image
    end
  end

  describe "form accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:login_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.login_element).to eql "form"
      end
    end

    it "should retrieve the form element from the page" do
      expect(watir_browser).to receive(:form).and_return(watir_browser)
      element = watir_page_object.login_element
      expect(element).to be_instance_of PageObject::Elements::Form
    end
  end

  describe "list item accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:item_one)
        expect(watir_page_object).to respond_to(:item_one_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.item_one_element).to eql "list_item"
      end
    end

    it "should retrieve the text from the list item" do
      expect(watir_browser).to receive(:li).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.item_one).to eql "value"
    end

    it "should retrieve the list item element from the page" do
      expect(watir_browser).to receive(:li).and_return(watir_browser)
      element = watir_page_object.item_one_element
      expect(element).to be_instance_of PageObject::Elements::ListItem
    end
  end

  describe "unordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:menu_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.menu_element).to eql "unordered_list"
      end
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:ul).and_return(watir_browser)
      element = watir_page_object.menu_element
      expect(element).to be_instance_of PageObject::Elements::UnorderedList
    end
  end

  describe "ordered list accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:top_five_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.top_five_element).to eql "ordered_list"
      end
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:ol).and_return(watir_browser)
      element = watir_page_object.top_five_element
      expect(element).to be_instance_of PageObject::Elements::OrderedList
    end
  end

  describe "h1 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:heading1)
        expect(watir_page_object).to respond_to(:heading1_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.heading1_element).to eql "h1"
      end
    end

    it "should retrieve the text from the h1" do
      expect(watir_browser).to receive(:h1).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.heading1).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:h1).and_return(watir_browser)
      element = watir_page_object.heading1_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h2 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:heading2)
        expect(watir_page_object).to respond_to(:heading2_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.heading2_element).to eql "h2"
      end
    end

    it "should retrieve the text from the h2" do
      expect(watir_browser).to receive(:h2).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.heading2).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:h2).and_return(watir_browser)
      element = watir_page_object.heading2_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h3 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:heading3)
        expect(watir_page_object).to respond_to(:heading3_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.heading3_element).to eql "h3"
      end
    end

    it "should retrieve the text from the h3" do
      expect(watir_browser).to receive(:h3).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.heading3).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:h3).and_return(watir_browser)
      element = watir_page_object.heading3_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h4 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:heading4)
        expect(watir_page_object).to respond_to(:heading4_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.heading4_element).to eql "h4"
      end
    end

    it "should retrieve the text from the h4" do
      expect(watir_browser).to receive(:h4).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.heading4).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:h4).and_return(watir_browser)
      element = watir_page_object.heading4_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h5 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:heading5)
        expect(watir_page_object).to respond_to(:heading5_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.heading5_element).to eql "h5"
      end
    end

    it "should retrieve the text from the h5" do
      expect(watir_browser).to receive(:h5).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.heading5).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:h5).and_return(watir_browser)
      element = watir_page_object.heading5_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end

  describe "h6 accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:heading6)
        expect(watir_page_object).to respond_to(:heading6_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.heading6_element).to eql "h6"
      end
    end

    it "should retrieve the text from the h6" do
      expect(watir_browser).to receive(:h6).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.heading6).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:h6).and_return(watir_browser)
      element = watir_page_object.heading6_element
      expect(element).to be_instance_of PageObject::Elements::Heading
    end
  end


  describe "p accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:first_para)
        expect(watir_page_object).to respond_to(:first_para_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.first_para_element).to eql "p"
      end
    end

    it "should retrieve the text from the p" do
      expect(watir_browser).to receive(:p).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.first_para).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:p).and_return(watir_browser)
      element = watir_page_object.first_para_element
      expect(element).to be_instance_of PageObject::Elements::Paragraph
    end
  end

  describe "file_field accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:upload_me=)
        expect(watir_page_object).to respond_to(:upload_me_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.a_file_element).to eql "file_field"
      end
    end

    it "should set the file name" do
      expect(watir_browser).to receive(:file_field).and_return(watir_browser)
      expect(watir_browser).to receive(:set).with('some_file')
      watir_page_object.upload_me = 'some_file'
    end

    it "should retrieve a text field element" do
      expect(watir_browser).to receive(:file_field).and_return(watir_browser)
      element = watir_page_object.upload_me_element
      expect(element).to be_instance_of PageObject::Elements::FileField
    end
  end

  describe "area accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:img_area)
        expect(watir_page_object).to respond_to(:img_area_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.img_area_element).to eql "area"
      end
    end

    it "should click on the area" do
      expect(watir_browser).to receive(:area).and_return(watir_browser)
      expect(watir_browser).to receive(:click)
      watir_page_object.img_area
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:area).and_return(watir_browser)
      element = watir_page_object.img_area_element
      expect(element).to be_instance_of PageObject::Elements::Area
    end
  end

  describe "canvas accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:my_canvas_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.my_canvas_element).to eql "canvas"
      end
    end
  end

  describe "audio accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:acdc_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.acdc_element).to eql "audio"
      end
    end
  end

  describe "video accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:movie_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.movie_element).to eql "video"
      end
    end
  end

  describe "b accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:bold)
        expect(watir_page_object).to respond_to(:bold_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.bold_element).to eql "b"
      end
    end

    it "should retrieve the text from the b" do
      expect(watir_browser).to receive(:b).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.bold).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:b).and_return(watir_browser)
      element = watir_page_object.bold_element
      expect(element).to be_instance_of PageObject::Elements::Bold
    end
  end

  describe "i accessors" do
    context "when called on a page object" do
      it "should generate accessor methods" do
        expect(watir_page_object).to respond_to(:italic)
        expect(watir_page_object).to respond_to(:italic_element)
      end

      it "should call a block on the element method when present" do
        expect(block_page_object.italic_element).to eql "i"
      end
    end

    it "should retrieve the text from the i" do
      expect(watir_browser).to receive(:i).and_return(watir_browser)
      expect(watir_browser).to receive(:text).and_return("value")
      expect(watir_page_object.italic).to eql "value"
    end

    it "should retrieve the element from the page" do
      expect(watir_browser).to receive(:i).and_return(watir_browser)
      element = watir_page_object.italic_element
      expect(element).to be_instance_of PageObject::Elements::Italic
    end
  end

end
