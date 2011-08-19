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

Then /^I should be able to select "([^"]*)" from the list$/ do |value|
  @select_list.select(value)
end
