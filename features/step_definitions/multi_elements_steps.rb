class MultiElementsPage
  include PageObject
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
