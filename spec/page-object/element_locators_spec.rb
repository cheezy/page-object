require 'spec_helper'

class ElementLocatorsTestPageObject
  include PageObject
end


describe PageObject::ElementLocators do

  context "when using Watir" do
    let(:watir_browser) { mock_watir_browser }
    let(:watir_page_object) { ElementLocatorsTestPageObject.new(watir_browser) }
    
    it "should find a button element" do
      watir_browser.should_receive(:button).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.button_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Button
    end

    it "should find a button element using a default identifier" do
      watir_browser.should_receive(:button).with(:index => 0).and_return(watir_browser)
      watir_page_object.button_element
    end

    it "should find all button elements" do
      watir_browser.should_receive(:buttons).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.button_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Button
    end

    it "should find all buttons with no identifier" do
      watir_browser.should_receive(:buttons).with({}).and_return([watir_browser])
      watir_page_object.button_elements
    end
    
    it "should find a text field element" do
      watir_browser.should_receive(:text_field).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.text_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TextField
    end

    it "should find a text field element using a default identifier" do
      watir_browser.should_receive(:text_field).with(:index => 0).and_return(watir_browser)
      watir_page_object.text_field_element
    end

    it "should find all text field elements" do
      watir_browser.should_receive(:text_fields).with(:id => 'blah').and_return([watir_browser])
      watir_browser.should_receive(:tag_name).and_return('input')
      elements = watir_page_object.text_field_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TextField
    end

    it "should find all text fields with no identifier" do
      watir_browser.should_receive(:text_fields).with({}).and_return([watir_browser])
      watir_browser.should_receive(:tag_name).and_return('input')
      watir_page_object.text_field_elements
    end
    
    it "should find a hidden field element" do
      watir_browser.should_receive(:hidden).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.hidden_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::HiddenField
    end

    it "should find a hidden field using a default identifier" do
      watir_browser.should_receive(:hidden).with(:index => 0).and_return(watir_browser)
      watir_page_object.hidden_field_element
    end

    it "should find all hidden field elements" do
      watir_browser.should_receive(:hiddens).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.hidden_field_elements(:id => 'blah')
      elements[0].should be_instance_of(PageObject::Elements::HiddenField)
    end

    it "should find all hidden field elements using no identifier" do
      watir_browser.should_receive(:hiddens).with({}).and_return([watir_browser])
      watir_page_object.hidden_field_elements
    end
    
    it "should find a text area element" do
      watir_browser.should_receive(:textarea).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.text_area_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TextArea
    end

    it "should find a text area using a default identifier" do
      watir_browser.should_receive(:textarea).with(:index => 0).and_return(watir_browser)
      watir_page_object.text_area_element
    end

    it "should find all text area elements" do
      watir_browser.should_receive(:textareas).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.text_area_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TextArea 
    end

    it "should find all text area elements using no identifier" do
      watir_browser.should_receive(:textareas).with({}).and_return([watir_browser])
      watir_page_object.text_area_elements
    end
    
    it "should find a select list element" do
      watir_browser.should_receive(:select_list).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.select_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::SelectList
    end

    it "should find a select list using a default identifier" do
      watir_browser.should_receive(:select_list).with(:index => 0).and_return(watir_browser)
      watir_page_object.select_list_element
    end

    it "should find all select list elements" do
      watir_browser.should_receive(:select_lists).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.select_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::SelectList 
    end

    it "should find all select list elements using no identifier" do
      watir_browser.should_receive(:select_lists).with({}).and_return([watir_browser])
      watir_page_object.select_list_elements
    end
    
    it "should find a link element" do
      watir_browser.should_receive(:link).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.link_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Link
    end

    it "should find a link element using a default identifier" do
      watir_browser.should_receive(:link).with(:index => 0).and_return(watir_browser)
      watir_page_object.link_element
    end

    it "should find all link elements" do
      watir_browser.should_receive(:links).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.link_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Link 
    end

    it "should find all links using no identifier" do
      watir_browser.should_receive(:links).with({}).and_return([watir_browser])
      watir_page_object.link_elements
    end
    
    it "should find a check box" do
      watir_browser.should_receive(:checkbox).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.checkbox_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::CheckBox
    end

    it "should find a check box using a default identifier" do
      watir_browser.should_receive(:checkbox).with(:index => 0).and_return(watir_browser)
      watir_page_object.checkbox_element
    end

    it "should find all check box elements" do
      watir_browser.should_receive(:checkboxes).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.checkbox_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::CheckBox 
    end

    it "should find all check box elements using no identifier" do
      watir_browser.should_receive(:checkboxes).with({}).and_return([watir_browser])
      watir_page_object.checkbox_elements
    end
    
    it "should find a radio button" do
      watir_browser.should_receive(:radio).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.radio_button_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::RadioButton
    end

    it "should find a radio button using a default identifier" do
      watir_browser.should_receive(:radio).with(:index => 0).and_return(watir_browser)
      watir_page_object.radio_button_element
    end

    it "should find all radio buttons" do
      watir_browser.should_receive(:radios).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.radio_button_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::RadioButton 
    end

    it "should find all radio buttons using no identifier" do
      watir_browser.should_receive(:radios).with({}).and_return([watir_browser])
      watir_page_object.radio_button_elements
    end
    
    it "should find a div" do
      watir_browser.should_receive(:div).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.div_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Div
    end

    it "should find a div using a default identifier" do
      watir_browser.should_receive(:div).with(:index => 0).and_return(watir_browser)
      watir_page_object.div_element
    end

    it "should find all div elements" do
      watir_browser.should_receive(:divs).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.div_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Div 
    end

    it "should find all div elements using no identifier" do
      watir_browser.should_receive(:divs).with({}).and_return([watir_browser])
      watir_page_object.div_elements
    end
    
    it "should find a span" do
      watir_browser.should_receive(:span).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.span_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Span
    end

    it "should find a span using a default identifier" do
      watir_browser.should_receive(:span).with(:index => 0).and_return(watir_browser)
      watir_page_object.span_element
    end

    it "should find all span elements" do
      watir_browser.should_receive(:spans).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.span_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Span 
    end

    it "should find all span elements using no identifier" do
      watir_browser.should_receive(:spans).with({}).and_return([watir_browser])
      watir_page_object.span_elements
    end
    
    it "should find a table" do
      watir_browser.should_receive(:table).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.table_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Table
    end

    it "should find a table using a default identifier" do
      watir_browser.should_receive(:table).with(:index => 0).and_return(watir_browser)
      watir_page_object.table_element
    end

    it "should find all table elements" do
      watir_browser.should_receive(:tables).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.table_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Table 
    end

    it "should find all table elements using no identifier" do
      watir_browser.should_receive(:tables).with({}).and_return([watir_browser])
      watir_page_object.table_elements
    end
    
    it "should find a table cell" do
      watir_browser.should_receive(:td).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.cell_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TableCell
    end

    it "should find a table cell using a default identifier" do
      watir_browser.should_receive(:td).with(:index => 0).and_return(watir_browser)
      watir_page_object.cell_element
    end

    it "should find all table cells" do
      watir_browser.should_receive(:tds).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.cell_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TableCell 
    end

    it "should find all table cells using no identifier" do
      watir_browser.should_receive(:tds).with({}).and_return([watir_browser])
      watir_page_object.cell_elements
    end
    
    it "should find an image" do
      watir_browser.should_receive(:image).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.image_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Image
    end

    it "should find an image using a default identifier" do
      watir_browser.should_receive(:image).with(:index => 0).and_return(watir_browser)
      watir_page_object.image_element
    end

    it "should find all images" do
      watir_browser.should_receive(:images).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.image_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Image
    end

    it "should find all images using no identifier" do
      watir_browser.should_receive(:images).with({}).and_return([watir_browser])
      watir_page_object.image_elements
    end
    
    it "should find a form" do
      watir_browser.should_receive(:form).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.form_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Form
    end

    it "should find a form using a default identifier" do
      watir_browser.should_receive(:form).with(:index => 0).and_return(watir_browser)
      watir_page_object.form_element
    end

    it "should find all forms" do
      watir_browser.should_receive(:forms).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.form_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Form
    end

    it "should find all forms using no identifier" do
      watir_browser.should_receive(:forms).with({}).and_return([watir_browser])
      watir_page_object.form_elements
    end
    
    it "should find a list item" do
      watir_browser.should_receive(:li).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.list_item_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::ListItem
    end

    it "should find a list item using a default identifier" do
      watir_browser.should_receive(:li).with(:index => 0).and_return(watir_browser)
      watir_page_object.list_item_element
    end

    it "should find all list items" do
      watir_browser.should_receive(:lis).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.list_item_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::ListItem 
    end

    it "should find all list items using no parameter" do
      watir_browser.should_receive(:lis).with({}).and_return([watir_browser])
      watir_page_object.list_item_elements
    end
    
    it "should find an unordered list" do
      watir_browser.should_receive(:ul).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.unordered_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::UnorderedList
    end

    it "should find an unordered list using a default identifier" do
      watir_browser.should_receive(:ul).with(:index => 0).and_return(watir_browser)
      watir_page_object.unordered_list_element
    end

    it "should find all unordered lists" do
      watir_browser.should_receive(:uls).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.unordered_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::UnorderedList 
    end

    it "should find all unordered lists using no parameters" do
      watir_browser.should_receive(:uls).with({}).and_return([watir_browser])
      watir_page_object.unordered_list_elements
    end
    
    it "should find an ordered list" do
      watir_browser.should_receive(:ol).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.ordered_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::OrderedList
    end

    it "should find an orderd list using a default identifier" do
      watir_browser.should_receive(:ol).with(:index => 0).and_return(watir_browser)
      watir_page_object.ordered_list_element
    end

    it "should find all ordered lists" do
      watir_browser.should_receive(:ols).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.ordered_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::OrderedList 
    end

    it "should find all orderd lists using no parameters" do
      watir_browser.should_receive(:ols).with({}).and_return([watir_browser])
      watir_page_object.ordered_list_elements
    end
    
    it "should find a h1 element" do
      watir_browser.should_receive(:h1).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h1_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find a h1 element using a default identifier" do
      watir_browser.should_receive(:h1).with(:index => 0).and_return(watir_browser)
      watir_page_object.h1_element
    end

    it "should find all h1 elements" do
      watir_browser.should_receive(:h1s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h1_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find all h1 elements using no parameters" do
      watir_browser.should_receive(:h1s).with({}).and_return([watir_browser])
      watir_page_object.h1_elements
    end

    it "should find a h2 element" do
      watir_browser.should_receive(:h2).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h2_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find a h2 element using default identifier" do
      watir_browser.should_receive(:h2).with(:index => 0).and_return(watir_browser)
      watir_page_object.h2_element
    end

    it "should find all h2 elements" do
      watir_browser.should_receive(:h2s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h2_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find all h2 elements using no identifier" do
      watir_browser.should_receive(:h2s).with({}).and_return([watir_browser])
      watir_page_object.h2_elements
    end

    it "should find a h3 element" do
      watir_browser.should_receive(:h3).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h3_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find a h3 element using a default identifier" do
      watir_browser.should_receive(:h3).with(:index => 0).and_return(watir_browser)
      watir_page_object.h3_element
    end

    it "should find all h3 elements" do
      watir_browser.should_receive(:h3s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h3_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find all h3 elements using no identifiers" do
      watir_browser.should_receive(:h3s).with({}).and_return([watir_browser])
      watir_page_object.h3_elements
    end

    it "should find a h4 element" do
      watir_browser.should_receive(:h4).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h4_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find a h4 element using a default identifier" do
      watir_browser.should_receive(:h4).with(:index => 0).and_return(watir_browser)
      watir_page_object.h4_element
    end

    it "should find all h4 elements" do
      watir_browser.should_receive(:h4s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h4_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find all h4 elements using no identifier" do
      watir_browser.should_receive(:h4s).with({}).and_return([watir_browser])
      watir_page_object.h4_elements
    end

    it "should find a h5 element" do
      watir_browser.should_receive(:h5).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h5_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find a h5 element using a default identifier" do
      watir_browser.should_receive(:h5).with(:index => 0).and_return(watir_browser)
      watir_page_object.h5_element
    end

    it "should find all h5 elements" do
      watir_browser.should_receive(:h5s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h5_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find all h5 elements using no identifier" do
      watir_browser.should_receive(:h5s).with({}).and_return([watir_browser])
      watir_page_object.h5_elements
    end

    it "should find a h6 element" do
      watir_browser.should_receive(:h6).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h6_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find a h6 element using a default identifier" do
      watir_browser.should_receive(:h6).with(:index => 0).and_return(watir_browser)
      watir_page_object.h6_element
    end

    it "should find all h6 elements" do
      watir_browser.should_receive(:h6s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h6_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find all h6 elements using no identifier" do
      watir_browser.should_receive(:h6s).with({}).and_return([watir_browser])
      watir_page_object.h6_elements
    end

    it "should find a paragraph element" do
      watir_browser.should_receive(:p).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.paragraph_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Paragraph
    end

    it "should find a paragraph element using a default identifier" do
      watir_browser.should_receive(:p).with(:index => 0).and_return(watir_browser)
      watir_page_object.paragraph_element
    end

    it "should find all paragraph elements" do
      watir_browser.should_receive(:ps).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.paragraph_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Paragraph 
    end

    it "should find all paragraph elements using no identifier" do
      watir_browser.should_receive(:ps).with({}).and_return([watir_browser])
      watir_page_object.paragraph_elements
    end

    it "should find a label" do
      watir_browser.should_receive(:label).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.label_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Label
    end

    it "should find a label element using default parameters" do
      watir_browser.should_receive(:label).with(:index => 0).and_return(watir_browser)
      watir_page_object.label_element
    end

    it "should find all label elements" do
      watir_browser.should_receive(:labels).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.label_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Label
    end

    it "should find all label elements using no parameters" do
      watir_browser.should_receive(:labels).with({}).and_return([watir_browser])
      watir_page_object.label_elements
    end

    it "should find a file field element" do
      watir_browser.should_receive(:file_field).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.file_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::FileField
    end

    it "should find a file field element using a default identifier" do
      watir_browser.should_receive(:file_field).with(:index => 0).and_return(watir_browser)
      watir_page_object.file_field_element
    end

    it "should find all file field elements" do
      watir_browser.should_receive(:file_fields).with(:id => 'blah').and_return([watir_browser])
      element = watir_page_object.file_field_elements(:id => 'blah')
      element[0].should be_instance_of PageObject::Elements::FileField
    end

    it "should find all file fields using no identifier" do
      watir_browser.should_receive(:file_fields).with({}).and_return([watir_browser])
      watir_page_object.file_field_elements
    end

    it "should find an area element" do
      watir_browser.should_receive(:area).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.area_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Area
    end

    it "should find an area element using a default identifier" do
      watir_browser.should_receive(:area).with(:index => 0).and_return(watir_browser)
      watir_page_object.area_element
    end

    it "should find all area elements" do
      watir_browser.should_receive(:areas).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.area_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Area
    end

    it "should find all areas with no identifier" do
      watir_browser.should_receive(:areas).with({}).and_return([watir_browser])
      watir_page_object.area_elements
    end
    
    it "should find a canvas element" do
      watir_browser.should_receive(:canvas).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.canvas_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Canvas
    end

    it "should find a canvas element using a default identifier" do
      watir_browser.should_receive(:canvas).with(:index => 0).and_return(watir_browser)
      watir_page_object.canvas_element
    end

    it "should find all canvas elements" do
      watir_browser.should_receive(:canvases).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.canvas_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Canvas
    end

    it "should find all canvases with no identifier" do
      watir_browser.should_receive(:canvases).with({}).and_return([watir_browser])
      watir_page_object.canvas_elements
    end

    it "should find an audio element" do
      watir_browser.should_receive(:audio).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.audio_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Audio
    end

    it "should find an audio element using a default identifier" do
      watir_browser.should_receive(:audio).with(:index => 0).and_return(watir_browser)
      watir_page_object.audio_element
    end

    it "should find all audio elements" do
      watir_browser.should_receive(:audios).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.audio_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Audio
    end

    it "should find all audio elements with no identifier" do
      watir_browser.should_receive(:audios).with({}).and_return([watir_browser])
      watir_page_object.audio_elements
    end

    it "should find a video element" do
      watir_browser.should_receive(:video).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.video_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Video
    end

    it "should find a video element using a default identifier" do
      watir_browser.should_receive(:video).with(:index => 0).and_return(watir_browser)
      watir_page_object.video_element
    end

    it "should find all video elements" do
      watir_browser.should_receive(:videos).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.video_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Video
    end

    it "should find all video elements with no identifier" do
      watir_browser.should_receive(:videos).with({}).and_return([watir_browser])
      watir_page_object.video_elements
    end

    it "should find an element" do
      watir_browser.should_receive(:audio).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.element(:audio, :id => 'blah')
      element.should be_instance_of PageObject::Elements::Element
    end

    it "should find an element using a default identifier" do
      watir_browser.should_receive(:audio).with(:index => 0).and_return(watir_browser)
      watir_page_object.element(:audio)
    end
  end

  context "when using Selenium" do
    let(:selenium_browser) { mock_selenium_browser }
    let(:selenium_page_object) { ElementLocatorsTestPageObject.new(selenium_browser) }
    
    it "should find a button element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.button_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Button
    end

    it "should find all button elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.button_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Button
    end

    it "should find a text field element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.text_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TextField
    end

    it "should find all text field elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.text_field_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TextField
    end

    it "should find a hidden field element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.hidden_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::HiddenField
    end

    it "should find all hidden field elements" do
      selenium_browser.should_receive(:find_elements).with(:id, "blah").and_return([selenium_browser])
      elements = selenium_page_object.hidden_field_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::HiddenField 

    end
    
    it "should find a text area element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.text_area_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TextArea
    end

    it "should find all text area elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.text_area_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TextArea 
    end
    
    it "should find a select list element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.select_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::SelectList
    end

    it "should find all select list elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.select_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::SelectList 
    end
    
    it "should find a link element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.link_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Link
    end

    it "should find all link elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.link_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Link 
    end
    
    it "should find a check box" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.checkbox_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::CheckBox
    end

    it "should find all checkbox elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.checkbox_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::CheckBox 
    end
    
    it "should find a radio button" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.radio_button_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::RadioButton
    end

    it "should find all radio button elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.radio_button_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::RadioButton 
    end
    
    it "should find a div" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.div_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Div
    end

    it "should find all div elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.div_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Div 
    end
    
    it "should find a span" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.span_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Span
    end

    it "should find all span elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.span_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Span 
    end
    
    it "should find a table" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.table_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Table
    end
    
    it "should find all table elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.table_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Table 
    end
    
    it "should find a table cell" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.cell_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TableCell
    end

    it "should find all table cell elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.cell_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TableCell 
    end

    it "should find an image" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.image_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Image
    end

    it "should find all image elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.image_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Image
    end
    
    it "should find a form" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.form_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Form
    end
    
    it "should find all forms" do
       selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
       elements = selenium_page_object.form_elements(:id => 'blah')
       elements[0].should be_instance_of PageObject::Elements::Form
    end

    it "should find a list item" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.list_item_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::ListItem
    end

    it "should find all list items" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      element = selenium_page_object.list_item_elements(:id => 'blah')
      element[0].should be_instance_of PageObject::Elements::ListItem 
    end
    
    it "should find an unordered list" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.unordered_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::UnorderedList
    end

    it "should find all unordered lists" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.unordered_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::UnorderedList 
    end
    
    it "should find an ordered list" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.ordered_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::OrderedList
    end

    it "should find all orderd list elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.ordered_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::OrderedList 
    end
    
    it "should find a h1 element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h1_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h1 elements" do
      selenium_browser.should_receive(:find_elements).with(:id, "blah").and_return([selenium_browser])
      elements = selenium_page_object.h1_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h2 element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h2_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h2 elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h2_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h3 element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h3_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h3 elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h3_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h4 element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h4_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h4 elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h4_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading
    end

    it "should find a h5 element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h5_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h5 elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h5_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h6 element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.h6_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h6 elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.h6_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a paragraph element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.paragraph_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Paragraph
    end

    it "should find all paragraph elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.paragraph_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Paragraph 
    end

    it "should find a label" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.label_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Label
    end

    it "should find all label elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.label_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Label
    end    

    it "should find a file field element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.file_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::FileField
    end

        it "should find an area element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.area_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Area
    end

    it "should find an area element using a default identifier" do
      selenium_browser.should_receive(:find_element).with(:xpath, '(.//area)[1]').and_return(selenium_browser)
      selenium_page_object.area_element
    end

    it "should find all area elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.area_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Area
    end

    it "should find all areas with no identifier" do
      selenium_browser.should_receive(:find_elements).with(:tag_name, 'area').and_return([selenium_browser])
      selenium_page_object.area_elements
    end

    it "should find a canvas element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.canvas_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Canvas
    end

    it "should find a canvas element using a default identifier" do
      selenium_browser.should_receive(:find_element).with(:xpath, '(.//canvas)[1]').and_return(selenium_browser)
      selenium_page_object.canvas_element
    end

    it "should find all canvas elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.canvas_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Canvas
    end

    it "should find all canvases with no identifier" do
      selenium_browser.should_receive(:find_elements).with(:tag_name, 'canvas').and_return([selenium_browser])
      selenium_page_object.canvas_elements
    end

    it "should find an audio element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.audio_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Audio
    end

    it "should find an audio element using a default identifier" do
      selenium_browser.should_receive(:find_element).with(:xpath, '(.//audio)[1]').and_return(selenium_browser)
      selenium_page_object.audio_element
    end

    it "should find all audio elements" do
      selenium_browser.should_receive(:find_elements).with(:id, 'blah').and_return([selenium_browser])
      elements = selenium_page_object.audio_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Audio
    end

    it "should find all audio elements with no identifier" do
      selenium_browser.should_receive(:find_elements).with(:tag_name, 'audio').and_return([selenium_browser])
      selenium_page_object.audio_elements
    end
  end
end
