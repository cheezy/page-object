When /^I select "([^\"]*)" from the select list$/ do |text|
  @page.sel_list_id = text
end

When /^I search for the select list by "([^\"]*)"$/ do |how|
  @how = how
end

When /^I search for the select list by "([^"]*)" and "([^"]*)"$/ do |param1, param2|
  @how = "#{param1}_#{param2}"
end

Then /^I should be able to select "([^\"]*)"$/ do |value|
  @page.send "sel_list_#{@how}=".to_sym, value
end

Then /^the value for the selected item should be "([^\"]*)"$/ do |value|
  result = @page.send "sel_list_#{@how}".to_sym
  expect(result).to eql value
end

When /^I find a select list while the script is executing$/ do
  @select_list = @page.select_list_element(:id => 'sel_list_id')
end

Then /^I should be able to select "([^\"]*)" from the list$/ do |value|
  @select_list.select(value)
end

Then /^I should see that the select list exists$/ do
  expect(@page.sel_list_id?).to eql true
end

Then /^the selected option should be "([^\"]*)"$/ do |text|
  expect(@page.select_list_element(:id => 'sel_list_id').selected_options[0]).to eql text
end

Then /^the select list should include "([^\"]*)"$/ do |text|
  expect(@page.sel_list_id_element).to include text
end

Then /^the select list should know that "([^\"]*)" is selected$/ do |text|
  expect(@page.sel_list_id_element.selected?(text)).to be true
end

Then /^the value for the option should be "([^\"]*)"$/ do |value|
  element = @page.send "sel_list_#{@how}_element".to_sym
  expect(element.value).to eql value
end

When /^I clear multiple select list$/ do
  @page.sel_list_multiple_element.clear
end

Then /^multiple select list should have no selected options$/ do
  expect(@page.sel_list_multiple_element.selected_options).to be_empty
end

When /^I select an option using the value "([^\"]*)"$/ do |value|
  @page.sel_list_id_element.select_value(value)
end

Then /^the selected option should have a value of "([^\"]*)"$/ do |value|
  expect(@page.sel_list_id_element.selected_values[0]).to eql value
end


And(/^cleared multiple select list should return nil for value$/) do
  expect(@page.sel_list_multiple).to be nil
end