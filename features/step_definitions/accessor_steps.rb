When /^I type "([^\"]*)" into the text field$/ do |text|
  @page.text_field_id = text
end

Then /^the text field should contain "([^\"]*)"$/ do |expected_text|
  @page.text_field_id.should == expected_text
end

When /^I search for the text field by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to type "([^\"]*)" into the field$/ do |value|
  @page.send "text_field_#{@how}=".to_sym, value
end

When /^I select the link labeled "([^\"]*)"$/ do |text|
  @page.google_search_id
end

When /^I search for the link by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to select the link$/ do
  @page.send "google_search_#{@how}".to_sym
end

When /^I select "([^\"]*)" from the select list$/ do |text|
  @page.sel_list_id = text
end

Then /^the current item should be "([^\"]*)"$/ do |expected_text|
  @page.sel_list_id.should == expected_text
end

When /^I search for the select list by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to select "([^\"]*)"$/ do |value|
  @page.send "sel_list_#{@how}=".to_sym, value
end

Then /^the value for the selected item should be "([^\"]*)"$/ do |value|
  result = @page.send "sel_list_#{@how}".to_sym
  result.should == value
end

When /^I select the First check box$/ do
  @page.check_cb_id
end

Then /^the First check box should be selected$/ do
  @page.cb_id_checked?.should be_true
end

When /^I unselect the First check box$/ do
  @page.uncheck_cb_id
end

Then /^the First check box should not be selected$/ do
  @page.cb_id_checked?.should be_false
end

When /^I search for the check box by "([^\"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to check the check box$/ do
  @page.send "check_cb_#{@how}".to_sym
end

When /^I select the "([^\"]*)" radio button$/ do |how|
  @page.send "select_#{how.downcase}_id".to_sym
end

Then /^the "([^\"]*)" radio button should be selected$/ do |how|
  @page.send "#{how.downcase}_id_selected?".to_sym
end

When /^I search for the radio button by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I select the radio button$/ do 
  @page.send "select_milk_#{@how}".to_sym
end

When /^I get the text from the div$/ do
  @text = @page.div_id
end

Then /^the text should be "([^"]*)"$/ do |expected_text|
  @text.should == expected_text
end

When /^I search for the div by "([^"]*)"$/ do |how|
  @text = @page.send "div_#{how}".to_sym
end

When /^I get the text from the span$/ do
  @text = @page.span_id
end

When /^I search for the span by "([^"]*)"$/ do |how|
  @text = @page.send "span_#{how}".to_sym
end


When /^I click the button$/ do
  @page.button_id
end

Then /^I should be on the success page$/ do
  @page.text.should include 'Success'
  @page.title.should == 'Success'
end

When /^I search for the button by "([^"]*)"$/ do |how|
  @how = how
end

Then /^I should be able to click the button$/ do
  @page.send "button_#{@how}"
end

When /^I search for the table cell by "([^"]*)"$/ do |how|
  @cell_data = @page.send "cell_#{how}"
end

When /^I retrieve a table element by "([^"]*)"$/ do |how|
  @element = @page.send "table_#{how}_table"
end
