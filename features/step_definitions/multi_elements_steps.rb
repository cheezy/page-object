class MultiElementsPage
  include PageObject

  divs(:the_divs, :class => 'div')
  divs(:block_divs) do |page|
    page.div_elements(:class => 'div')
  end
  buttons(:the_buttons, :class => 'button')
  text_fields(:the_text_fields, :class => 'textfield')
  hidden_fields(:the_hidden_fields, :class => 'hiddenfield')
  text_areas(:the_text_areas, :class => 'textarea')
  select_lists(:the_select_lists, :class => 'selectlist')
  links(:the_links, :class => 'link')
  checkboxes(:the_checkboxes, :class => 'checkbox')
  radio_buttons(:the_radio_buttons, :class => 'radio')
  spans(:the_spans, :class => 'span')
  tables(:the_tables, :class => 'table')
  cells(:the_cells, :class => 'td')
  images(:the_images, :class => 'image')
  forms(:the_forms, :class => 'form')
  list_items(:the_list_items, :class => 'li')
  unordered_lists(:the_unordered_lists, :class => 'ul')
  ordered_lists(:the_ordered_lists, :class => 'ol')
  h1s(:the_h1s, :class => 'h1')
  h2s(:the_h2s, :class => 'h2')
  h3s(:the_h3s, :class => 'h3')
  h4s(:the_h4s, :class => 'h4')
  h5s(:the_h5s, :class => 'h5')
  h6s(:the_h6s, :class => 'h6')
  paragraphs(:the_paragraphs, :class => 'p')
  labels(:the_labels, :class => 'label')
  file_fields(:the_file_fields, :class => 'file_field_class')
  elements(:generic_label, :label, :class => 'label')
  b(:bs)
  i(:is)
end


Given /^I am on the multi elements page$/ do
  @page = MultiElementsPage.new(@browser)
  @page.navigate_to(UrlHelper.multi)
end

When /^I select the buttons with class "([^\"]*)"$/ do |class_name|
  @elements = @page.button_elements(:class => class_name)
end

Then /^I should have (\d+) buttons$/ do |num_buttons|
  @elements.size.should == num_buttons.to_i
end

Then /^the value of button (\d+) should be "([^\"]*)"$/ do |button_num, value|
  @elements[button_num.to_i - 1].value.should == value
end

When /^I select the text fields with class "([^\"]*)"$/ do |class_name|
  @elements = @page.text_field_elements(:class => class_name)
end

Then /^I should have (\d+) text fields$/ do |num_text_fields|
  @elements.size.should == num_text_fields.to_i
end

Then /^the value of text field (\d+) should be "([^\"]*)"$/ do |text_field_num, value|
  @elements[text_field_num.to_i - 1].value.should == value
end

When /^I select the hidden fields with class "([^\"]*)"$/ do |class_name|
  @elements = @page.hidden_field_elements(:class => class_name)
end

Then /^I should have (\d+) hidden fields$/ do |num_hidden_fields|
  @elements.size.should == num_hidden_fields.to_i
end

Then /^the value of hidden field (\d+) should be "([^\"]*)"$/ do |hidden_field_num, value|
  @elements[hidden_field_num.to_i - 1].value.should == value
end

When /^I select the text areas with class "([^\"]*)"$/ do |class_name|
  @elements = @page.text_area_elements(:class => class_name)
end

Then /^I should have (\d+) text areas$/ do |num_text_areas|
  @elements.size.should == num_text_areas.to_i
end

Then /^the value of text area (\d+) should be "([^\"]*)"$/ do |text_area_num, value|
  @elements[text_area_num.to_i - 1].value.should == value
end

When /^I select the select lists with class "([^\"]*)"$/ do |class_name|
  @elements = @page.select_list_elements(:class => class_name)
end

Then /^I should have (\d+) select lists$/ do |num_select_lists|
  @elements.size.should == num_select_lists.to_i
end

Then /^the value of select list (\d+) should be "([^\"]*)"$/ do |select_list_num, value|
  @elements[select_list_num.to_i - 1].value.should == value
end

When /^I select the link with class "([^\"]*)"$/ do |link_class|
  @elements = @page.link_elements(:class => link_class)
end

Then /^I should have (\d+) links$/ do |num_links|
  @elements.size.should == num_links.to_i
end

Then /^the text of link (\d+) should be "([^\"]*)"$/ do |link_num, text|
  @elements[link_num.to_i - 1].text.should == text
end

When /^I select the check boxes with class "([^\"]*)"$/ do |class_name|
  @elements = @page.checkbox_elements(:class => class_name)
end

Then /^I should have (\d+) checkboxes$/ do |num_checkboxes|
  @elements.size.should == num_checkboxes.to_i
end

Then /^the value of checkbox (\d+) should be "([^\"]*)"$/ do |checkbox_num, value|
  @elements[checkbox_num.to_i - 1].value.should == value
end

When /^I select the radio button with class "([^\"]*)"$/ do |class_name|
  @elements = @page.radio_button_elements(:class => class_name)
end

Then /^I should have (\d+) radio buttons$/ do |num_radio_buttons|
  @elements.size.should == num_radio_buttons.to_i
end

Then /^the value of radio button (\d+) should be "([^\"]*)"$/ do |radio_button_num, value|
  @elements[radio_button_num.to_i - 1].value.should == value
end

When /^I select the div with class "([^\"]*)"$/ do |class_name|
  @elements = @page.div_elements(:class => class_name)
end

Then /^I should have (\d+) divs$/ do |num_divs|
  @elements.size.should == num_divs.to_i
end

Then /^the text of div (\d+) should be "([^\"]*)"$/ do |div_num, text|
  @elements[div_num.to_i - 1].text.should == text
end

When /^I select the spans with class "([^\"]*)"$/ do |class_name|
  @elements = @page.span_elements(:class => class_name)
end

Then /^I should have (\d+) spans$/ do |num_spans|
  @elements.size.should == num_spans.to_i
end

Then /^the text of span (\d+) should be "([^\"]*)"$/ do |span_num, text|
  @elements[span_num.to_i - 1].text.should == text
end

When /^I select the tables with class "([^\"]*)"$/ do |class_name|
  @elements = @page.table_elements(:class => class_name)
end

Then /^I should have (\d+) tables$/ do |num_tables|
  @elements.size.should == num_tables.to_i
end

Then /^the first row first column for table (\d+) should have "([^\"]*)"$/ do |table_num, text|
  @elements[table_num.to_i - 1][0][0].text.should == text
end

When /^I select the cells with class "([^\"]*)"$/ do |cell_class|
  @elements = @page.cell_elements(:class => cell_class)
end

Then /^I should have (\d+) cells$/ do |num_cells|
  @elements.size.should == num_cells.to_i
end

Then /^the text for cell (\d+) should be "([^\"]*)"$/ do |cell_num, text|
  @elements[cell_num.to_i - 1].text.should == text
end

When /^I select the images with class "([^\"]*)"$/ do |class_name|
  @elements = @page.image_elements(:class => class_name)
end

Then /^I should have (\d+) images$/ do |num_images|
  @elements.size.should == num_images.to_i
end

Then /^the alt for image (\d+) should be "([^\"]*)"$/ do |image_num, alt|
  @elements[image_num.to_i - 1].attribute(:alt).should == alt
end

When /^I select the forms with class "([^\"]*)"$/ do |class_name|
  @elements = @page.form_elements(:class => class_name)
end

Then /^I should have (\d+) forms$/ do |number|
  @elements.size.should == number.to_i
end

Then /^the action for form (\d+) should be "([^\"]*)"$/ do |form_number, action|
  @elements[form_number.to_i-1].attribute(:action).should match action
end

When /^I select the list items with class "([^\"]*)"$/ do |class_name|
  @elements = @page.list_item_elements(:class => class_name)
end

Then /^I should have (\d+) list items$/ do |num_list_items|
  @elements.size.should == num_list_items.to_i
end

Then /^the text for list item (\d+) should be "([^\"]*)"$/ do |list_item_num, text|
  @elements[list_item_num.to_i - 1].text.should == text
end

When /^I select the unordered list with class "([^\"]*)"$/ do |class_name|
  @elements = @page.unordered_list_elements(:class => class_name)
end

Then /^I should have (\d+) unordered lists$/ do |num_unordered_lists|
  @elements.size.should == num_unordered_lists.to_i
end

Then /^the text for the first item in unordered list (\d+) should be "([^\"]*)"$/ do |ul_num, text|
  @elements[ul_num.to_i - 1][0].text.should == text
end

When /^I select the ordered lists with class "([^\"]*)"$/ do |class_name|
  @elements = @page.ordered_list_elements(:class => class_name)
end

Then /^I should have (\d+) ordered lists$/ do |num_ol|
  @elements.size.should == num_ol.to_i
end

Then /^the text for the first item in ordered list (\d+) should be "([^\"]*)"$/ do |ol_num, text|
  @elements[ol_num.to_i - 1][0].text.should == text
end

When /^I select the h1s with class "([^\"]*)"$/ do |class_name|
  @elements = @page.h1_elements(:class => class_name)
end

Then /^I should have (\d+) h1s$/ do |num_h1s|
  @elements.size.should == num_h1s.to_i
end

Then /^the text for h1 (\d+) should be "([^\"]*)"$/ do |h1_num, text|
  @elements[h1_num.to_i - 1].text.should == text
end

When /^I select the h2s with the class "([^\"]*)"$/ do |class_name|
  @elements = @page.h2_elements(:class => class_name)
end

Then /^I should have (\d+) h2s$/ do |num_h2s|
  @elements.size.should == num_h2s.to_i
end

Then /^the text for h2 (\d+) should be "([^\"]*)"$/ do |h2_num, text|
  @elements[h2_num.to_i - 1].text.should == text
end

When /^I select the h3s with the class "([^\"]*)"$/ do |class_name|
  @elements = @page.h3_elements(:class => class_name)
end

Then /^I should have (\d+) h3s$/ do |num_h3s|
  @elements.size.should == num_h3s.to_i
end

Then /^the text for h3 (\d+) should be "([^\"]*)"$/ do |h3_num, text|
  @elements[h3_num.to_i - 1].text.should == text
end

When /^I select the h4s with the class "([^\"]*)"$/ do |class_name|
  @elements = @page.h4_elements(:class => class_name)
end

Then /^I should have (\d+) h4s$/ do |num_h4s|
  @elements.size.should == num_h4s.to_i
end

Then /^the text for H4 (\d+) should be "([^\"]*)"$/ do |h4_num, text|
  @elements[h4_num.to_i - 1].text.should == text
end

When /^I select the h5s with the class "([^\"]*)"$/ do |class_name|
  @elements = @page.h5_elements(:class => class_name)
end

Then /^I should have (\d+) h5s$/ do |num_h5s|
  @elements.size.should == num_h5s.to_i
end

Then /^the text for H5 (\d+) should be "([^\"]*)"$/ do |h5_num, text|
  @elements[h5_num.to_i - 1].text.should == text
end

When /^I select the h6s with the class "([^\"]*)"$/ do |class_name|
  @elements = @page.h6_elements(:class => class_name)
end

Then /^I should have (\d+) h6s$/ do |num_h6s|
  @elements.size.should == num_h6s.to_i
end

Then /^the text for H6 (\d+) should be "([^\"]*)"$/ do |h6_num, text|
  @elements[h6_num.to_i - 1].text.should == text
end

When /^I select the paragraph with class "([^\"]*)"$/ do |class_name|
  @elements = @page.paragraph_elements(:class => class_name)
end

Then /^I should have (\d+) paragraphs$/ do |num_paragraphs|
  @elements.size.should == num_paragraphs.to_i
end

Then /^the text for paragraph (\d+) should be "([^\"]*)"$/ do |para_num, text|
  @elements[para_num.to_i - 1].text.should == text
end

When /^I select all buttons using no identifier$/ do
  @elements = @page.button_elements
end

When /^I select all text fields using no identifier$/ do
  @elements = @page.text_field_elements
end

When /^I select all hidden fields using no identifier$/ do
  @elements = @page.hidden_field_elements
end

When /^I select text areas using no identifier$/ do
  @elements = @page.text_area_elements
end

When /^I select select lists using no identifier$/ do
  @elements = @page.select_list_elements
end

When /^I select links using no identifier$/ do
  @elements = @page.link_elements
end

When /^I select checboxes using no identifier$/ do
  @elements = @page.checkbox_elements
end

When /^I select radio buttons using no identifier$/ do
  @elements = @page.radio_button_elements
end

When /^I select divs using no identifier$/ do
  @elements = @page.div_elements
end

When /^I select spans using no identifier$/ do
  @elements = @page.span_elements
end

When /^I select tables using no identifier$/ do
  @elements = @page.table_elements
end

When /^I select the cells using no identifier$/ do
  @elements = @page.cell_elements
end

When /^I select the images using no identifier$/ do
  @elements = @page.image_elements
end

When /^I select the forms using no identifier$/ do
  @elements = @page.form_elements
end

When /^I select the list items using no identifier$/ do
  @elements = @page.list_item_elements
end

When /^I select the unordered list using no parameter$/ do
  @elements = @page.unordered_list_elements
end

When /^I select the ordered lists using no identifier$/ do
  @elements = @page.ordered_list_elements
end

When /^I select h(\d+)s using no identifier$/ do |num|
  @elements = @page.send "h#{num}_elements"
end

When /^I select paragraphs using no identifier$/ do
  @elements = @page.paragraph_elements
end

When /^I select the labels with class "([^\"]*)"$/ do |class_name|
  @elements = @page.label_elements(:class => class_name)
end

Then /^I should have (\d+) labels$/ do |num_labels|
  @elements.size.should == num_labels.to_i
end

Then /^the text for label (\d+) should be "([^\"]*)"$/ do |label_num, text|
  @elements[label_num.to_i - 1].text.should == text
end

When /^I select labels using no identifier$/ do
  @elements = @page.label_elements
end

When /^I select the file fields with class "([^\"]*)"$/ do |class_name|
  @elements = @page.file_field_elements(:class => class_name)
end

Then /^I should have (\d+) file fields$/ do |num_file_fields|
  @elements.size.should == num_file_fields.to_i
end

Then /^the title for file field (\d+) should be "([^\"]*)"$/ do |file_field_num, title|
  @elements[file_field_num.to_i - 1].attribute('title').should == title
end

When /^I select the file fields using no identifier$/ do
  @elements = @page.file_field_elements
end

When /^I select the divs using the generated method$/ do
  @elements = @page.the_divs_elements
end

When /^I select the buttons using the generated method$/ do
  @elements = @page.the_buttons_elements
end

When /^I select the text fields using the generated method$/ do
  @elements = @page.the_text_fields_elements
end

When /^I select the hidden fields using the generated method$/ do
  @elements = @page.the_hidden_fields_elements
end

When /^I select the text areas using the generated method$/ do
  @elements = @page.the_text_areas_elements
end

When /^I select the select lists using the generated method$/ do
  @elements = @page.the_select_lists_elements
end

When /^I select the link using the generated method$/ do
  @elements = @page.the_links_elements
end

When /^I select the check boxes using the generated method$/ do
  @elements = @page.the_checkboxes_elements
end

When /^I select the radio button using the generated method$/ do
  @elements = @page.the_radio_buttons_elements
end

When /^I select the spans using the generated method$/ do
  @elements = @page.the_spans_elements
end

When /^I select the tables using the generated method$/ do
  @elements = @page.the_tables_elements
end

When /^I select the cells using the generated method$/ do
  @elements = @page.the_cells_elements
end

When /^I select the images using the generated method$/ do
  @elements = @page.the_images_elements
end

When /^I select the forms using the generated method$/ do
  @elements = @page.the_forms_elements
end

When /^I select the list items using the generated method$/ do
  @elements = @page.the_list_items_elements
end

When /^I select the unordered list using the generated method$/ do
  @elements = @page.the_unordered_lists_elements
end

When /^I select the ordered lists using the generated method$/ do
  @elements = @page.the_ordered_lists_elements
end

When /^I select the h(\d+)s using the generated method$/ do |num|
  @elements = @page.send "the_h#{num.to_i}s_elements"
end

When /^I select the paragraph using the generated method$/ do
  @elements = @page.the_paragraphs_elements
end

When /^I select the labels using the generated method$/ do
  @elements = @page.the_labels_elements
end

When /^I select the file fields using the generated method$/ do
  @elements = @page.the_file_fields_elements
end

When /^I select the divs using a block$/ do
  @elements = @page.block_divs_elements
end

When(/^I select the multiple elements with a tag label$/) do
  @elements = @page.generic_label_elements
end

When /^I select the bs$/ do
  @elements = @page.b_elements
end

Then /^I should have (\d+) bs$/ do |num_bs|
  @elements.size.should == num_bs.to_i
end

Then /^the text for b (\d+) should be "([^\"]*)"$/ do |b_num, text|
  @elements[b_num.to_i - 1].text.should == text
end

When /^I select the is$/ do
  @elements = @page.i_elements
end

Then /^I should have (\d+) is$/ do |num_is|
  @elements.size.should == num_is.to_i
end

Then /^the text for i (\d+) should be "([^\"]*)"$/ do |i_num, text|
  @elements[i_num.to_i - 1].text.should == text
end
