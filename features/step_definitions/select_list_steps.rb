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
  result.should == value
end

When /^I find a select list while the script is executing$/ do
  @select_list = @page.select_list_element(:id => 'sel_list_id')
end

Then /^I should be able to select "([^\"]*)" from the list$/ do |value|
  @select_list.select(value)
end

Then /^I should see that the select list exists$/ do
  @page.sel_list_id?.should == true
end

Then /^the selected option should be "([^\"]*)"$/ do |text|
  @page.select_list_element(:id => 'sel_list_id').selected_options[0].should == text
end

Then /^the select list should include "([^\"]*)"$/ do |text|
  @page.sel_list_id_element.should include text
end

Then /^the select list should know that "([^\"]*)" is selected$/ do |text|
  @page.sel_list_id_element.selected?(text).should be_true
end

Then /^the value for the option should be "([^\"]*)"$/ do |value|
  element = @page.send "sel_list_#{@how}_element".to_sym
  element.value.should == value
end

When /^I clear multiple select list$/ do
  @page.sel_list_multiple_element.clear
end

Then /^multiple select list should have no selected options$/ do
  @page.sel_list_multiple_element.selected_options.should be_empty
end

When /^I select an option using the value "([^\"]*)"$/ do |value|
  @page.sel_list_id_element.select_value(value)
end

Then /^the selected option should have a value of "([^\"]*)"$/ do |value|
  @page.sel_list_id_element.selected_values[0].should == value
end
