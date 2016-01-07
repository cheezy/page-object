require 'spec_helper'

class ElementLocatorsTestPageObject
  include PageObject
end


describe PageObject::ElementLocators do

  context "when using Watir" do
    let(:watir_browser) { mock_watir_browser }
    let(:watir_page_object) { ElementLocatorsTestPageObject.new(watir_browser) }

    it "should find a button element" do
      expect(watir_browser).to receive(:button).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.button_element(:id => 'blah')
      expect(element).to  be_instance_of PageObject::Elements::Button
    end

    it "should find a button element using a default identifier" do
      expect(watir_browser).to receive(:button).with(:index => 0).and_return(watir_browser)
      watir_page_object.button_element
    end

    it "should find all button elements" do
      expect(watir_browser).to receive(:buttons).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.button_elements(:id => 'blah')
      expect(elements[0]).to  be_instance_of PageObject::Elements::Button
    end

    it "should find all buttons with no identifier" do
      expect(watir_browser).to receive(:buttons).with({}).and_return([watir_browser])
      watir_page_object.button_elements
    end

    it "should find a text field element" do
      expect(watir_browser).to receive(:text_field).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.text_field_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::TextField
    end

    it "should find a text field element using a default identifier" do
      expect(watir_browser).to receive(:text_field).with(:index => 0).and_return(watir_browser)
      watir_page_object.text_field_element
    end

    it "should find all text field elements" do
      expect(watir_browser).to receive(:text_fields).with(:id => 'blah').and_return([watir_browser])
      expect(watir_browser).to receive(:tag_name).and_return('input')
      elements = watir_page_object.text_field_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::TextField
    end

    it "should find all text fields with no identifier" do
      expect(watir_browser).to receive(:text_fields).with({}).and_return([watir_browser])
      expect(watir_browser).to receive(:tag_name).and_return('input')
      watir_page_object.text_field_elements
    end

    it "should find a hidden field element" do
      expect(watir_browser).to receive(:hidden).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.hidden_field_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::HiddenField
    end

    it "should find a hidden field using a default identifier" do
      expect(watir_browser).to receive(:hidden).with(:index => 0).and_return(watir_browser)
      watir_page_object.hidden_field_element
    end

    it "should find all hidden field elements" do
      expect(watir_browser).to receive(:hiddens).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.hidden_field_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of(PageObject::Elements::HiddenField)
    end

    it "should find all hidden field elements using no identifier" do
      expect(watir_browser).to receive(:hiddens).with({}).and_return([watir_browser])
      watir_page_object.hidden_field_elements
    end

    it "should find a text area element" do
      expect(watir_browser).to receive(:textarea).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.text_area_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::TextArea
    end

    it "should find a text area using a default identifier" do
      expect(watir_browser).to receive(:textarea).with(:index => 0).and_return(watir_browser)
      watir_page_object.text_area_element
    end

    it "should find all text area elements" do
      expect(watir_browser).to receive(:textareas).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.text_area_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::TextArea
    end

    it "should find all text area elements using no identifier" do
      expect(watir_browser).to receive(:textareas).with({}).and_return([watir_browser])
      watir_page_object.text_area_elements
    end

    it "should find a select list element" do
      expect(watir_browser).to receive(:select_list).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.select_list_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::SelectList
    end

    it "should find a select list using a default identifier" do
      expect(watir_browser).to receive(:select_list).with(:index => 0).and_return(watir_browser)
      watir_page_object.select_list_element
    end

    it "should find all select list elements" do
      expect(watir_browser).to receive(:select_lists).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.select_list_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::SelectList
    end

    it "should find all select list elements using no identifier" do
      expect(watir_browser).to receive(:select_lists).with({}).and_return([watir_browser])
      watir_page_object.select_list_elements
    end

    it "should find a link element" do
      expect(watir_browser).to receive(:link).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.link_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Link
    end

    it "should find a link element using a default identifier" do
      expect(watir_browser).to receive(:link).with(:index => 0).and_return(watir_browser)
      watir_page_object.link_element
    end

    it "should find all link elements" do
      expect(watir_browser).to receive(:links).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.link_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Link
    end

    it "should find all links using no identifier" do
      expect(watir_browser).to receive(:links).with({}).and_return([watir_browser])
      watir_page_object.link_elements
    end

    it "should find a check box" do
      expect(watir_browser).to receive(:checkbox).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.checkbox_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::CheckBox
    end

    it "should find a check box using a default identifier" do
      expect(watir_browser).to receive(:checkbox).with(:index => 0).and_return(watir_browser)
      watir_page_object.checkbox_element
    end

    it "should find all check box elements" do
      expect(watir_browser).to receive(:checkboxes).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.checkbox_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::CheckBox
    end

    it "should find all check box elements using no identifier" do
      expect(watir_browser).to receive(:checkboxes).with({}).and_return([watir_browser])
      watir_page_object.checkbox_elements
    end

    it "should find a radio button" do
      expect(watir_browser).to receive(:radio).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.radio_button_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::RadioButton
    end

    it "should find a radio button using a default identifier" do
      expect(watir_browser).to receive(:radio).with(:index => 0).and_return(watir_browser)
      watir_page_object.radio_button_element
    end

    it "should find all radio buttons" do
      expect(watir_browser).to receive(:radios).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.radio_button_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::RadioButton
    end

    it "should find all radio buttons using no identifier" do
      expect(watir_browser).to receive(:radios).with({}).and_return([watir_browser])
      watir_page_object.radio_button_elements
    end

    it "should find a div" do
      expect(watir_browser).to receive(:div).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.div_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Div
    end

    it "should find a div using a default identifier" do
      expect(watir_browser).to receive(:div).with(:index => 0).and_return(watir_browser)
      watir_page_object.div_element
    end

    it "should find all div elements" do
      expect(watir_browser).to receive(:divs).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.div_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Div
    end

    it "should find all div elements using no identifier" do
      expect(watir_browser).to receive(:divs).with({}).and_return([watir_browser])
      watir_page_object.div_elements
    end

    it "should find a span" do
      expect(watir_browser).to receive(:span).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.span_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Span
    end

    it "should find a span using a default identifier" do
      expect(watir_browser).to receive(:span).with(:index => 0).and_return(watir_browser)
      watir_page_object.span_element
    end

    it "should find all span elements" do
      expect(watir_browser).to receive(:spans).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.span_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Span
    end

    it "should find all span elements using no identifier" do
      expect(watir_browser).to receive(:spans).with({}).and_return([watir_browser])
      watir_page_object.span_elements
    end

    it "should find a table" do
      expect(watir_browser).to receive(:table).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.table_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Table
    end

    it "should find a table using a default identifier" do
      expect(watir_browser).to receive(:table).with(:index => 0).and_return(watir_browser)
      watir_page_object.table_element
    end

    it "should find all table elements" do
      expect(watir_browser).to receive(:tables).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.table_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Table
    end

    it "should find all table elements using no identifier" do
      expect(watir_browser).to receive(:tables).with({}).and_return([watir_browser])
      watir_page_object.table_elements
    end

    it "should find a table cell" do
      expect(watir_browser).to receive(:td).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.cell_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::TableCell
    end

    it "should find a table cell using a default identifier" do
      expect(watir_browser).to receive(:td).with(:index => 0).and_return(watir_browser)
      watir_page_object.cell_element
    end

    it "should find all table cells" do
      expect(watir_browser).to receive(:tds).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.cell_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::TableCell
    end

    it "should find all table cells using no identifier" do
      expect(watir_browser).to receive(:tds).with({}).and_return([watir_browser])
      watir_page_object.cell_elements
    end

    it "should find a table row" do
      expect(watir_browser).to receive(:tr).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.row_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::TableRow
    end

    it "should find a table row using a default identifier" do
      expect(watir_browser).to receive(:tr).with(:index => 0).and_return(watir_browser)
      watir_page_object.row_element
    end

    it "should find all table row" do
      expect(watir_browser).to receive(:trs).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.row_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::TableRow
    end

    it "should find all table rows using no identifier" do
      expect(watir_browser).to receive(:trs).with({}).and_return([watir_browser])
      watir_page_object.row_elements
    end

    it "should find an image" do
      expect(watir_browser).to receive(:image).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.image_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Image
    end

    it "should find an image using a default identifier" do
      expect(watir_browser).to receive(:image).with(:index => 0).and_return(watir_browser)
      watir_page_object.image_element
    end

    it "should find all images" do
      expect(watir_browser).to receive(:images).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.image_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Image
    end

    it "should find all images using no identifier" do
      expect(watir_browser).to receive(:images).with({}).and_return([watir_browser])
      watir_page_object.image_elements
    end

    it "should find a form" do
      expect(watir_browser).to receive(:form).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.form_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Form
    end

    it "should find a form using a default identifier" do
      expect(watir_browser).to receive(:form).with(:index => 0).and_return(watir_browser)
      watir_page_object.form_element
    end

    it "should find all forms" do
      expect(watir_browser).to receive(:forms).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.form_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Form
    end

    it "should find all forms using no identifier" do
      expect(watir_browser).to receive(:forms).with({}).and_return([watir_browser])
      watir_page_object.form_elements
    end

    it "should find a list item" do
      expect(watir_browser).to receive(:li).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.list_item_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::ListItem
    end

    it "should find a list item using a default identifier" do
      expect(watir_browser).to receive(:li).with(:index => 0).and_return(watir_browser)
      watir_page_object.list_item_element
    end

    it "should find all list items" do
      expect(watir_browser).to receive(:lis).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.list_item_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::ListItem
    end

    it "should find all list items using no parameter" do
      expect(watir_browser).to receive(:lis).with({}).and_return([watir_browser])
      watir_page_object.list_item_elements
    end

    it "should find an unordered list" do
      expect(watir_browser).to receive(:ul).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.unordered_list_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::UnorderedList
    end

    it "should find an unordered list using a default identifier" do
      expect(watir_browser).to receive(:ul).with(:index => 0).and_return(watir_browser)
      watir_page_object.unordered_list_element
    end

    it "should find all unordered lists" do
      expect(watir_browser).to receive(:uls).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.unordered_list_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::UnorderedList
    end

    it "should find all unordered lists using no parameters" do
      expect(watir_browser).to receive(:uls).with({}).and_return([watir_browser])
      watir_page_object.unordered_list_elements
    end

    it "should find an ordered list" do
      expect(watir_browser).to receive(:ol).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.ordered_list_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::OrderedList
    end

    it "should find an orderd list using a default identifier" do
      expect(watir_browser).to receive(:ol).with(:index => 0).and_return(watir_browser)
      watir_page_object.ordered_list_element
    end

    it "should find all ordered lists" do
      expect(watir_browser).to receive(:ols).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.ordered_list_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::OrderedList
    end

    it "should find all orderd lists using no parameters" do
      expect(watir_browser).to receive(:ols).with({}).and_return([watir_browser])
      watir_page_object.ordered_list_elements
    end

    it "should find a h1 element" do
      expect(watir_browser).to receive(:h1).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h1_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h1 element using a default identifier" do
      expect(watir_browser).to receive(:h1).with(:index => 0).and_return(watir_browser)
      watir_page_object.h1_element
    end

    it "should find all h1 elements" do
      expect(watir_browser).to receive(:h1s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h1_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h1 elements using no parameters" do
      expect(watir_browser).to receive(:h1s).with({}).and_return([watir_browser])
      watir_page_object.h1_elements
    end

    it "should find a h2 element" do
      expect(watir_browser).to receive(:h2).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h2_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h2 element using default identifier" do
      expect(watir_browser).to receive(:h2).with(:index => 0).and_return(watir_browser)
      watir_page_object.h2_element
    end

    it "should find all h2 elements" do
      expect(watir_browser).to receive(:h2s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h2_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h2 elements using no identifier" do
      expect(watir_browser).to receive(:h2s).with({}).and_return([watir_browser])
      watir_page_object.h2_elements
    end

    it "should find a h3 element" do
      expect(watir_browser).to receive(:h3).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h3_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h3 element using a default identifier" do
      expect(watir_browser).to receive(:h3).with(:index => 0).and_return(watir_browser)
      watir_page_object.h3_element
    end

    it "should find all h3 elements" do
      expect(watir_browser).to receive(:h3s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h3_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h3 elements using no identifiers" do
      expect(watir_browser).to receive(:h3s).with({}).and_return([watir_browser])
      watir_page_object.h3_elements
    end

    it "should find a h4 element" do
      expect(watir_browser).to receive(:h4).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h4_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h4 element using a default identifier" do
      expect(watir_browser).to receive(:h4).with(:index => 0).and_return(watir_browser)
      watir_page_object.h4_element
    end

    it "should find all h4 elements" do
      expect(watir_browser).to receive(:h4s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h4_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h4 elements using no identifier" do
      expect(watir_browser).to receive(:h4s).with({}).and_return([watir_browser])
      watir_page_object.h4_elements
    end

    it "should find a h5 element" do
      expect(watir_browser).to receive(:h5).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h5_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h5 element using a default identifier" do
      expect(watir_browser).to receive(:h5).with(:index => 0).and_return(watir_browser)
      watir_page_object.h5_element
    end

    it "should find all h5 elements" do
      expect(watir_browser).to receive(:h5s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h5_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h5 elements using no identifier" do
      expect(watir_browser).to receive(:h5s).with({}).and_return([watir_browser])
      watir_page_object.h5_elements
    end

    it "should find a h6 element" do
      expect(watir_browser).to receive(:h6).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h6_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h6 element using a default identifier" do
      expect(watir_browser).to receive(:h6).with(:index => 0).and_return(watir_browser)
      watir_page_object.h6_element
    end

    it "should find all h6 elements" do
      expect(watir_browser).to receive(:h6s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h6_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h6 elements using no identifier" do
      expect(watir_browser).to receive(:h6s).with({}).and_return([watir_browser])
      watir_page_object.h6_elements
    end

    it "should find a paragraph element" do
      expect(watir_browser).to receive(:p).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.paragraph_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Paragraph
    end

    it "should find a paragraph element using a default identifier" do
      expect(watir_browser).to receive(:p).with(:index => 0).and_return(watir_browser)
      watir_page_object.paragraph_element
    end

    it "should find all paragraph elements" do
      expect(watir_browser).to receive(:ps).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.paragraph_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Paragraph
    end

    it "should find all paragraph elements using no identifier" do
      expect(watir_browser).to receive(:ps).with({}).and_return([watir_browser])
      watir_page_object.paragraph_elements
    end

    it "should find a label" do
      expect(watir_browser).to receive(:label).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.label_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Label
    end

    it "should find a label element using default parameters" do
      expect(watir_browser).to receive(:label).with(:index => 0).and_return(watir_browser)
      watir_page_object.label_element
    end

    it "should find all label elements" do
      expect(watir_browser).to receive(:labels).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.label_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Label
    end

    it "should find all label elements using no parameters" do
      expect(watir_browser).to receive(:labels).with({}).and_return([watir_browser])
      watir_page_object.label_elements
    end

    it "should find a file field element" do
      expect(watir_browser).to receive(:file_field).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.file_field_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::FileField
    end

    it "should find a file field element using a default identifier" do
      expect(watir_browser).to receive(:file_field).with(:index => 0).and_return(watir_browser)
      watir_page_object.file_field_element
    end

    it "should find all file field elements" do
      expect(watir_browser).to receive(:file_fields).with(:id => 'blah').and_return([watir_browser])
      element = watir_page_object.file_field_elements(:id => 'blah')
      expect(element[0]).to be_instance_of PageObject::Elements::FileField
    end

    it "should find all file fields using no identifier" do
      expect(watir_browser).to receive(:file_fields).with({}).and_return([watir_browser])
      watir_page_object.file_field_elements
    end

    it "should find an area element" do
      expect(watir_browser).to receive(:area).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.area_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Area
    end

    it "should find an area element using a default identifier" do
      expect(watir_browser).to receive(:area).with(:index => 0).and_return(watir_browser)
      watir_page_object.area_element
    end

    it "should find all area elements" do
      expect(watir_browser).to receive(:areas).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.area_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Area
    end

    it "should find all areas with no identifier" do
      expect(watir_browser).to receive(:areas).with({}).and_return([watir_browser])
      watir_page_object.area_elements
    end

    it "should find a canvas element" do
      expect(watir_browser).to receive(:canvas).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.canvas_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Canvas
    end

    it "should find a canvas element using a default identifier" do
      expect(watir_browser).to receive(:canvas).with(:index => 0).and_return(watir_browser)
      watir_page_object.canvas_element
    end

    it "should find all canvas elements" do
      expect(watir_browser).to receive(:canvases).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.canvas_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Canvas
    end

    it "should find all canvases with no identifier" do
      expect(watir_browser).to receive(:canvases).with({}).and_return([watir_browser])
      watir_page_object.canvas_elements
    end

    it "should find an audio element" do
      expect(watir_browser).to receive(:audio).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.audio_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Audio
    end

    it "should find an audio element using a default identifier" do
      expect(watir_browser).to receive(:audio).with(:index => 0).and_return(watir_browser)
      watir_page_object.audio_element
    end

    it "should find all audio elements" do
      expect(watir_browser).to receive(:audios).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.audio_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Audio
    end

    it "should find all audio elements with no identifier" do
      expect(watir_browser).to receive(:audios).with({}).and_return([watir_browser])
      watir_page_object.audio_elements
    end

    it "should find a video element" do
      expect(watir_browser).to receive(:video).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.video_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Video
    end

    it "should find a video element using a default identifier" do
      expect(watir_browser).to receive(:video).with(:index => 0).and_return(watir_browser)
      watir_page_object.video_element
    end

    it "should find all video elements" do
      expect(watir_browser).to receive(:videos).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.video_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Video
    end

    it "should find all video elements with no identifier" do
      expect(watir_browser).to receive(:videos).with({}).and_return([watir_browser])
      watir_page_object.video_elements
    end

    it "should find an element" do
      expect(watir_browser).to receive(:audio).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.element(:audio, :id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Element
    end

    it "should find an element using a default identifier" do
      expect(watir_browser).to receive(:audio).with(:index => 0).and_return(watir_browser)
      watir_page_object.element(:audio)
    end

    it "should find a b element" do
      expect(watir_browser).to receive(:b).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.b_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Bold
    end

    it "should find a b element using a default identifier" do
      expect(watir_browser).to receive(:b).with(:index => 0).and_return(watir_browser)
      watir_page_object.b_element
    end

    it "should find all b elements" do
      expect(watir_browser).to receive(:bs).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.b_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Bold
    end

    it "should find all b elements using no parameters" do
      expect(watir_browser).to receive(:bs).with({}).and_return([watir_browser])
      watir_page_object.b_elements
    end

    it "should find an i element" do
      expect(watir_browser).to receive(:i).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.i_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Italic
    end

    it "should find an i element using a default identifier" do
      expect(watir_browser).to receive(:i).with(:index => 0).and_return(watir_browser)
      watir_page_object.i_element
    end

    it "should find all i elements" do
      expect(watir_browser).to receive(:is).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.i_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Italic
    end

    it "should find all i elements using no parameters" do
      expect(watir_browser).to receive(:is).with({}).and_return([watir_browser])
      watir_page_object.i_elements
    end
  end

  context "when using Selenium" do
    let(:selenium_browser) { mock_selenium_browser }
    let(:selenium_page_object) { ElementLocatorsTestPageObject.new(selenium_browser) }

    it "should find a button element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.button_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Button
    end

    it "should find all button elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.button_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Button
    end

    it "should find a text field element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.text_field_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::TextField
    end

    it "should find all text field elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.text_field_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::TextField
    end

    it "should find a hidden field element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.hidden_field_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::HiddenField
    end

    it "should find all hidden field elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, "blah").and_return([selenium_browser])
      elements = selenium_page_object.hidden_field_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::HiddenField

    end

    it "should find a text area element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.text_area_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::TextArea
    end

    it "should find all text area elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.text_area_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::TextArea
    end

    it "should find a select list element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.select_list_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::SelectList
    end

    it "should find all select list elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.select_list_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::SelectList
    end

    it "should find a link element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.link_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Link
    end

    it "should find all link elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.link_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Link
    end

    it "should find a check box" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.checkbox_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::CheckBox
    end

    it "should find all checkbox elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.checkbox_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::CheckBox
    end

    it "should find a radio button" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.radio_button_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::RadioButton
    end

    it "should find all radio button elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.radio_button_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::RadioButton
    end

    it "should find a div" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.div_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Div
    end

    it "should find all div elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.div_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Div
    end

    it "should find a span" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.span_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Span
    end

    it "should find all span elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.span_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Span
    end

    it "should find a table" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.table_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Table
    end

    it "should find all table elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.table_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Table
    end

    it "should find a table cell" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.cell_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::TableCell
    end

    it "should find all table cell elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.cell_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::TableCell
    end

    it "should find an image" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.image_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Image
    end

    it "should find all image elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.image_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Image
    end

    it "should find a form" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.form_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Form
    end

    it "should find all forms" do
       expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
       elements = selenium_page_object.form_elements(:id => 'blah')
       expect(elements[0]).to be_instance_of PageObject::Elements::Form
    end

    it "should find a list item" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.list_item_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::ListItem
    end

    it "should find all list items" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      element = selenium_page_object.list_item_elements(:id => 'blah')
      expect(element[0]).to be_instance_of PageObject::Elements::ListItem
    end

    it "should find an unordered list" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.unordered_list_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::UnorderedList
    end

    it "should find all unordered lists" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.unordered_list_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::UnorderedList
    end

    it "should find an ordered list" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.ordered_list_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::OrderedList
    end

    it "should find all orderd list elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.ordered_list_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::OrderedList
    end

    it "should find a h1 element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h1_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h1 elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, "blah").and_return([selenium_browser])
      elements = selenium_page_object.h1_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h2 element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h2_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h2 elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h2_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h3 element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h3_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h3 elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h3_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h4 element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h4_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h4 elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h4_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h5 element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h5_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h5 elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h5_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a h6 element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h6_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Heading
    end

    it "should find all h6 elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h6_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Heading
    end

    it "should find a paragraph element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.paragraph_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Paragraph
    end

    it "should find all paragraph elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.paragraph_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Paragraph
    end

    it "should find a label" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.label_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Label
    end

    it "should find all label elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.label_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Label
    end

    it "should find a file field element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.file_field_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::FileField
    end

        it "should find an area element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.area_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Area
    end

    it "should find an area element using a default identifier" do
      expect(selenium_browser).to receive(:find_element).with(:xpath, '(.//area)[1]').and_return(selenium_browser)
      selenium_page_object.area_element
    end

    it "should find all area elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.area_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Area
    end

    it "should find all areas with no identifier" do
      expect(selenium_browser).to receive(:find_elements).with(:tag_name, 'area').and_return([selenium_browser])
      selenium_page_object.area_elements
    end

    it "should find a canvas element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.canvas_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Canvas
    end

    it "should find a canvas element using a default identifier" do
      expect(selenium_browser).to receive(:find_element).with(:xpath, '(.//canvas)[1]').and_return(selenium_browser)
      selenium_page_object.canvas_element
    end

    it "should find all canvas elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.canvas_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Canvas
    end

    it "should find all canvases with no identifier" do
      expect(selenium_browser).to receive(:find_elements).with(:tag_name, 'canvas').and_return([selenium_browser])
      selenium_page_object.canvas_elements
    end

    it "should find an audio element" do
      expect(selenium_browser).to receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.audio_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Audio
    end

    it "should find an audio element using a default identifier" do
      expect(selenium_browser).to receive(:find_element).with(:xpath, '(.//audio)[1]').and_return(selenium_browser)
      selenium_page_object.audio_element
    end

    it "should find all audio elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.audio_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Audio
    end

    it "should find all audio elements with no identifier" do
      expect(selenium_browser).to receive(:find_elements).with(:tag_name, 'audio').and_return([selenium_browser])
      selenium_page_object.audio_elements
    end
    it "should find an i element" do
      expect(selenium_browser).to receive(:find_element).with(:id,'blah').and_return(selenium_browser)
      element = selenium_page_object.i_element(:id => 'blah')
      expect(element).to be_instance_of PageObject::Elements::Italic
    end


    it "should find all i elements" do
      expect(selenium_browser).to receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.i_elements(:id => 'blah')
      expect(elements[0]).to be_instance_of PageObject::Elements::Italic
    end

  end
end
