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

    it "should find all button elements" do
      watir_browser.should_receive(:buttons).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.button_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Button
    end
    
    it "should find a text field element" do
      watir_browser.should_receive(:text_field).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.text_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TextField
    end

    it "should find all text field elements" do
      watir_browser.should_receive(:text_fields).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.text_field_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TextField
    end
    
    it "should find a hidden field element" do
      watir_browser.should_receive(:hidden).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.hidden_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::HiddenField
    end

    it "should find all hidden field elements" do
      watir_browser.should_receive(:hiddens).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.hidden_field_elements(:id => 'blah')
      elements[0].should be_instance_of(PageObject::Elements::HiddenField)
    end
    
    it "should find a text area element" do
      watir_browser.should_receive(:textarea).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.text_area_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TextArea
    end

    it "should find all text area elements" do
      watir_browser.should_receive(:textareas).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.text_area_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TextArea 
    end
    
    it "should find a select list element" do
      watir_browser.should_receive(:select_list).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.select_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::SelectList
    end

    it "should find all select list elements" do
      watir_browser.should_receive(:select_lists).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.select_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::SelectList 
    end
    
    it "should find a link element" do
      watir_browser.should_receive(:link).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.link_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Link
    end

    it "should find all link elements" do
      watir_browser.should_receive(:links).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.link_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Link 
    end
    
    it "should find a check box" do
      watir_browser.should_receive(:checkbox).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.checkbox_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::CheckBox
    end

    it "should find all check box elements" do
      watir_browser.should_receive(:checkboxes).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.checkbox_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::CheckBox 
    end
    
    it "should find a radio button" do
      watir_browser.should_receive(:radio).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.radio_button_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::RadioButton
    end

    it "should find all radio buttons" do
      watir_browser.should_receive(:radios).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.radio_button_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::RadioButton 
    end
    
    it "should find a div" do
      watir_browser.should_receive(:div).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.div_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Div
    end

    it "should find all div elements" do
      watir_browser.should_receive(:divs).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.div_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Div 
    end
    
    it "should find a span" do
      watir_browser.should_receive(:span).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.span_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Span
    end

    it "should find all span elements" do
      watir_browser.should_receive(:spans).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.span_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Span 
    end
    
    it "should find a table" do
      watir_browser.should_receive(:table).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.table_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Table
    end

    it "should find all table elements" do
      watir_browser.should_receive(:tables).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.table_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Table 
    end
    
    it "should find a table cell" do
      watir_browser.should_receive(:td).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.cell_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::TableCell
    end

    it "should find all table cells" do
      watir_browser.should_receive(:tds).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.cell_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::TableCell 
    end
    
    it "should find an image" do
      watir_browser.should_receive(:image).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.image_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Image
    end

    it "should find all images" do
      watir_browser.should_receive(:images).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.image_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Image
    end
    
    it "should find a form" do
      watir_browser.should_receive(:form).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.form_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Form
    end

    it "should find all forms" do
      watir_browser.should_receive(:forms).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.form_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Form
    end
    
    it "should find a list item" do
      watir_browser.should_receive(:li).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.list_item_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::ListItem
    end

    it "should find all list items" do
      watir_browser.should_receive(:lis).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.list_item_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::ListItem 
    end
    
    it "should find an unordered list" do
      watir_browser.should_receive(:ul).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.unordered_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::UnorderedList
    end

    it "should find all unordered lists" do
      watir_browser.should_receive(:uls).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.unordered_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::UnorderedList 
    end
    
    it "should find an ordered list" do
      watir_browser.should_receive(:ol).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.ordered_list_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::OrderedList
    end

    it "should find all ordered lists" do
      watir_browser.should_receive(:ols).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.ordered_list_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::OrderedList 
    end
    
    it "should find a h1 element" do
      watir_browser.should_receive(:h1).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h1_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "shoudl find all h1 elements" do
      watir_browser.should_receive(:h1s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h1_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h2 element" do
      watir_browser.should_receive(:h2).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h2_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h2 elements" do
      watir_browser.should_receive(:h2s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h2_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h3 element" do
      watir_browser.should_receive(:h3).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h3_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h3 elements" do
      watir_browser.should_receive(:h3s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h3_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h4 element" do
      watir_browser.should_receive(:h4).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h4_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h4 elements" do
      watir_browser.should_receive(:h4s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h4_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h5 element" do
      watir_browser.should_receive(:h5).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h5_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find all h5 elements" do
      watir_browser.should_receive(:h5s).with(:id => 'blah').and_return([watir_browser])
      elements = watir_page_object.h5_elements(:id => 'blah')
      elements[0].should be_instance_of PageObject::Elements::Heading 
    end

    it "should find a h6 element" do
      watir_browser.should_receive(:h6).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.h6_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Heading
    end

    it "should find a paragraph element" do
      watir_browser.should_receive(:p).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.paragraph_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Paragraph
    end

    it "should find a file field element" do
      watir_browser.should_receive(:file_field).with(:id => 'blah').and_return(watir_browser)
      element = watir_page_object.file_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::FileField
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

    it "should find a paragraph element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.paragraph_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::Paragraph
    end

    it "should find a file field element" do
      selenium_browser.should_receive(:find_element).with(:id, 'blah').and_return(selenium_browser)
      element = selenium_page_object.file_field_element(:id => 'blah')
      element.should be_instance_of PageObject::Elements::FileField
    end
  end
end
