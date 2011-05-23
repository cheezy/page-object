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
  


Then /^I should know it exists$/ do
  @element.should exist
end

Then /^I should know it is visible$/ do
  @element.should be_visible
end

