When /^I retrieve a check box element$/ do
  @element = @page.cb_id_checkbox
end

When /^I retrieve a link element$/ do
  @element = @page.google_search_id_link
end

When /^I retrieve a radio button$/ do
  @element = @page.milk_id_radio_button
end

When /^I retrieve a select list$/ do
  @element = @page.sel_list_id_select_list
end

When /^I retrieve a text field$/ do
  @element = @page.text_field_id_text_field
end

When /^I retrieve the div element$/ do
  @element = @page.div_id_div
end

When /^I retrieve a table element$/ do
  @element = @page.table_id_table
end

When /^I retrieve a button element$/ do
  @element = @page.button_id_button
end

When /^I retrieve table cell$/ do
  @element = @page.cell_id_cell
end
  
When /^I locate the form$/ do
  @element = @page.form_id_form
end


Then /^I should know it exists$/ do
  @element.should exist
end

Then /^I should know it is visible$/ do
  @element.should be_visible
end

Then /^I should know it is not visible$/ do
  @element.should_not be_visible
end

Then /^I should know its' text is "([^"]*)"$/ do |text|
  @element.text.should == text
end

Then /^I should know its' text includes "([^"]*)"$/ do |text|
  @element.text.should include text
end

Then /^I should know its' value is "([^"]*)"$/ do |value|
  @element.value.should == value
end

Then /^I should know its' value is nil$/ do
  @element.value.should be_nil
end

Then /^I should know it is equal to itself$/ do
  @element.should == @element
end

Then /^I should know its' tag name is "([^"]*)"$/ do |tagname|
  @element.tag_name.should == tagname
end

Then /^I should know the attribute "([^"]*)" is false$/ do |attr_name|
  @attr = @element.attribute(attr_name)
  @attr.should be_false if @attr.is_a? FalseClass
  @attr.should == "false" if @attr.is_a? String
end

Then /^I should be able to click it$/ do
  @element.click
end
